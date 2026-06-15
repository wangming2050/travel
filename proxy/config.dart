// ============================================
// 文件: proxy/config.dart
// 用途: DeepSeek API 代理配置
// 说明:
//   - deepseekApiKey: 从环境变量 DEEPSEEK_API_KEY 读取
//   - port: 代理服务器监听端口
// ============================================

import 'dart:io';

/// 代理服务器配置
class ProxyConfig {
  /// DeepSeek API Key — 不要写入源码或提交到 Git
  static String get deepseekApiKey =>
      Platform.environment['DEEPSEEK_API_KEY'] ?? '';

  /// DeepSeek API 地址
  static String get deepseekBaseUrl =>
      Platform.environment['DEEPSEEK_BASE_URL'] ?? 'https://api.deepseek.com';

  /// 代理服务器监听端口
  static int get port =>
      int.tryParse(Platform.environment['PROXY_PORT'] ?? '') ?? 8080;
}
