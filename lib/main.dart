// ============================================
// 文件: lib/main.dart
// 用途: App 启动入口（当前: 太原）
// 说明: 切换到其他城市时，替换 runApp 中的 App 即可
//       例如: runApp(const ChengduApp())
// ============================================

import 'package:flutter/material.dart';
import 'taiyuan/ty_taiyuan_app.dart';

void main() => runApp(const TaiyuanApp());
