// ============================================
// 文件: proxy/server.dart
// 用途: DeepSeek API 代理服务器
// 说明:
//   - 接收 Flutter 端请求，转发到 DeepSeek API
//   - 自动注入 API Key（客户端无需持有 Key）
//   - 支持流式（SSE）透传
//   - 启动: dart run lib/server.dart
// ============================================

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

import 'config.dart';

/// CORS + 日志中间件
Middleware _pipeline() {
  return const Pipeline()
      .addMiddleware(corsHeaders(headers: {
        'ACCESS_CONTROL_ALLOW_ORIGIN': '*',
        'ACCESS_CONTROL_ALLOW_METHODS': 'GET, POST, OPTIONS',
        'ACCESS_CONTROL_ALLOW_HEADERS': 'Content-Type, Authorization',
      }))
      .addMiddleware(logRequests())
      .middleware;
}

/// 请求分发（手动路由，避免 shelf_router 匹配问题）
Future<Response> _handler(Request request) async {
  final path = request.url.path;
  final method = request.method;

  // 健康检查
  if (method == 'GET' && (path == 'health' || path == '/health')) {
    return Response.ok(
      jsonEncode({'status': 'ok', 'service': 'DeepSeek Proxy'}),
      headers: {'Content-Type': 'application/json'},
    );
  }

  // 聊天补全
  if (method == 'POST' &&
      (path == 'v1/chat/completions' || path == '/v1/chat/completions')) {
    return _handleChatCompletion(request);
  }

  // OPTIONS 预检
  if (method == 'OPTIONS') {
    return Response.ok('', headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type',
    });
  }

  // 404
  return Response.notFound(
    jsonEncode({
      'error': 'not found',
      'path': path,
      'method': method,
    }),
    headers: {'Content-Type': 'application/json'},
  );
}

/// 处理聊天补全请求
Future<Response> _handleChatCompletion(Request request) async {
  // 1. 读取请求体
  final body = await request.readAsString();

  Map<String, dynamic> jsonBody;
  try {
    jsonBody = jsonDecode(body) as Map<String, dynamic>;
  } catch (e) {
    return Response(400,
        body: jsonEncode({'error': 'invalid JSON body'}),
        headers: {'Content-Type': 'application/json'});
  }

  // 2. 检查 API Key
  if (ProxyConfig.deepseekApiKey.isEmpty) {
    return Response(500,
        body: jsonEncode(
            {'error': 'DeepSeek API Key 未配置，请设置 DEEPSEEK_API_KEY 环境变量'}),
        headers: {'Content-Type': 'application/json'});
  }

  final isStreaming = jsonBody['stream'] == true;

  // 3. 转发到 DeepSeek
  final client = HttpClient();
  client.connectionTimeout = const Duration(seconds: 120);

  try {
    final deepseekUri = Uri.parse(
        '${ProxyConfig.deepseekBaseUrl}/v1/chat/completions');
    final deepseekReq = await client.postUrl(deepseekUri);
    // 确保正确的编码
    final bodyBytes = utf8.encode(body);
    deepseekReq.headers.set('Content-Type', 'application/json; charset=utf-8');
    deepseekReq.headers.set('Content-Length', bodyBytes.length.toString());
    deepseekReq.headers
        .set('Authorization', 'Bearer ${ProxyConfig.deepseekApiKey}');
    deepseekReq.add(bodyBytes);

    final deepseekResp = await deepseekReq.close();

    if (deepseekResp.statusCode != 200) {
      final errorBody = await deepseekResp.transform(utf8.decoder).join();
      client.close();
      return Response(deepseekResp.statusCode,
          body: errorBody, headers: {'Content-Type': 'application/json'});
    }

    if (isStreaming) {
      final streamCtrl = StreamController<List<int>>();
      deepseekResp.transform(utf8.decoder).listen(
        (chunk) {
          streamCtrl.add(utf8.encode(chunk));
        },
        onDone: () {
          streamCtrl.close();
          client.close();
        },
        onError: (error) {
          streamCtrl.addError(error);
          streamCtrl.close();
          client.close();
        },
      );
      return Response.ok(
        streamCtrl.stream,
        headers: {
          'Content-Type': 'text/event-stream',
          'Cache-Control': 'no-cache',
          'Connection': 'keep-alive',
        },
      );
    } else {
      final respBody = await deepseekResp.transform(utf8.decoder).join();
      client.close();
      return Response.ok(respBody,
          headers: {'Content-Type': 'application/json'});
    }
  } catch (e) {
    client.close();
    return Response(502,
        body: jsonEncode({
          'error': '代理错误: 无法连接到 DeepSeek API',
          'detail': e.toString(),
        }),
        headers: {'Content-Type': 'application/json'});
  }
}

void main() async {
  final handler = _pipeline().addHandler(_handler);
  final server = await shelf_io.serve(handler, '0.0.0.0', ProxyConfig.port);

  print('🚀 DeepSeek 代理服务器已启动');
  print('   健康检查: http://localhost:${server.port}/health');
  print('   API 端点: POST http://localhost:${server.port}/v1/chat/completions');
}
