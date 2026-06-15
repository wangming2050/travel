// ============================================
// 文件: lib/ty_taiyuan_app.dart
// 用途: 太原城市 App 入口
// 作者: testerwm
// 创建: 2026-06-09
// 说明:
//   - 当前展示太原城市页面
//   - 其他成员替换 home 为自己的城市页即可
//   - 如需城市列表，在此文件添加路由或首页选择逻辑
// ============================================

import 'package:flutter/material.dart';
import 'structure/ty_taiyuan_city_page.dart';
import 'ty_app.dart';

/// 太原城市 App
/// 其他成员参考此结构，替换 tabs 为自己的 Tab 内容
class TaiyuanApp extends StatelessWidget {
  const TaiyuanApp();

  @override
  Widget build(BuildContext context) => const MyApp(home: TaiyuanCityPage());
}
