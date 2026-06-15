// ============================================
// 文件: lib/shared/ty_ai_service.dart
// 用途: AI 聊天服务 — 通过代理调用 DeepSeek API
// 说明:
//   - chatStream(): 流式聊天，返回 SSE 文本块
//   - chat(): 非流式聊天，返回完整回复
//   - 使用 http 包处理请求，确保中文字符正确编码
// ============================================

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'ty_ai_config.dart';

/// 聊天消息
class TyAiMessage {
  final String role; // 'system' | 'user' | 'assistant'
  final String content;

  const TyAiMessage({required this.role, required this.content});

  Map<String, dynamic> toJson() => {'role': role, 'content': content};
}

/// AI 聊天服务
class TyAiService {
  final String _baseUrl;
  final String _lang;
  final http.Client _client;

  TyAiService({String? baseUrl, String? lang, http.Client? client})
      : _baseUrl = baseUrl ?? TyAiConfig.proxyBaseUrl,
        _lang = lang ?? 'zh',
        _client = client ?? http.Client();

  /// 流式聊天 — 返回 SSE 文本块的 Stream
  Stream<String> chatStream(List<TyAiMessage> messages) async* {
    final jsonBody = _buildRequestBody(messages, stream: true);
    final bodyBytes = utf8.encode(jsonEncode(jsonBody));
    final uri = Uri.parse('$_baseUrl${TyAiConfig.chatEndpoint}');

    http.StreamedResponse? response;

    try {
      final request = http.StreamedRequest('POST', uri)
        ..headers['Content-Type'] = 'application/json; charset=utf-8'
        ..headers['Accept'] = 'text/event-stream'
        ..sink.add(bodyBytes)
        ..sink.close();

      response = await _client.send(request).timeout(
            const Duration(seconds: 60),
          );

      if (response.statusCode != 200) {
        final errorBody = await response.stream.bytesToString();
        String errorMsg;
        try {
          final err = jsonDecode(errorBody) as Map<String, dynamic>;
          errorMsg = err['error']?['message'] ??
              err['error']?.toString() ??
              errorBody;
        } catch (_) {
          errorMsg = '服务器错误 (${response.statusCode})';
        }
        throw TyAiException(errorMsg);
      }

      // 解析 SSE 流
      String buffer = '';
      await for (final chunk in response.stream.transform(utf8.decoder)) {
        buffer += chunk;
        while (buffer.contains('\n\n')) {
          final eventEnd = buffer.indexOf('\n\n');
          final event = buffer.substring(0, eventEnd);
          buffer = buffer.substring(eventEnd + 2);

          for (final line in event.split('\n')) {
            if (line.startsWith('data: ')) {
              final data = line.substring(6).trim();
              if (data == '[DONE]') return;

              try {
                final json = jsonDecode(data) as Map<String, dynamic>;
                final choices = json['choices'] as List<dynamic>?;
                if (choices != null && choices.isNotEmpty) {
                  final delta = choices[0]['delta'] as Map<String, dynamic>?;
                  final content = delta?['content'] as String?;
                  if (content != null && content.isNotEmpty) {
                    yield content;
                  }
                }
              } catch (_) {}
            }
          }
        }
      }
      // 残留数据
      if (buffer.trim().isNotEmpty) {
        final line = buffer.trim();
        if (line.startsWith('data: ')) {
          final data = line.substring(6).trim();
          if (data != '[DONE]') {
            try {
              final json = jsonDecode(data) as Map<String, dynamic>;
              final choices = json['choices'] as List<dynamic>?;
              if (choices != null && choices.isNotEmpty) {
                final delta = choices[0]['delta'] as Map<String, dynamic>?;
                final content = delta?['content'] as String?;
                if (content != null && content.isNotEmpty) {
                  yield content;
                }
              }
            } catch (_) {}
          }
        }
      }
    } on TyAiException {
      rethrow;
    } on TimeoutException {
      throw TyAiException('请求超时，请稍后重试');
    } catch (e) {
      if (e is TyAiException) rethrow;
      throw TyAiException('网络连接失败，请检查代理服务器是否已启动');
    } finally {
      // 注意：不在这里 dispose _client，因为它是共享的
    }
  }

  /// 非流式聊天 — 返回完整回复文本
  Future<String> chat(List<TyAiMessage> messages) async {
    final jsonBody = _buildRequestBody(messages, stream: false);
    final bodyBytes = utf8.encode(jsonEncode(jsonBody));
    final uri = Uri.parse('$_baseUrl${TyAiConfig.chatEndpoint}');

    try {
      final response = await _client
          .post(
            uri,
            headers: {'Content-Type': 'application/json; charset=utf-8'},
            body: bodyBytes,
          )
          .timeout(const Duration(seconds: 45));

      if (response.statusCode != 200) {
        throw TyAiException('API 错误 (${response.statusCode}): ${response.body}');
      }

      final body = utf8.decode(response.bodyBytes);
      final json = jsonDecode(body) as Map<String, dynamic>;
      final choices = json['choices'] as List<dynamic>?;
      if (choices != null && choices.isNotEmpty) {
        final message = choices[0]['message'] as Map<String, dynamic>?;
        return message?['content'] as String? ?? '';
      }
      return '';
    } on TyAiException {
      rethrow;
    } on TimeoutException {
      throw TyAiException('请求超时，请稍后重试');
    } catch (e) {
      if (e is TyAiException) rethrow;
      throw TyAiException('网络连接失败，请检查代理服务器是否已启动');
    }
  }

  /// 构建请求体
  Map<String, dynamic> _buildRequestBody(
    List<TyAiMessage> messages, {
    required bool stream,
  }) {
    final systemMsg = TyAiMessage(
      role: 'system',
      content: TyAiConfig.systemPrompt(_lang),
    );

    return {
      'model': TyAiConfig.model,
      'messages': [systemMsg.toJson(), ...messages.map((m) => m.toJson())],
      'stream': stream,
      'temperature': 0.7,
      'max_tokens': 2000,
    };
  }

  void dispose() {
    _client.close();
  }
}

/// AI 服务异常
class TyAiException implements Exception {
  final String message;
  const TyAiException(this.message);

  @override
  String toString() => message;
}
