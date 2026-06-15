// ============================================
// 文件: lib/ty_app.dart
// 用途: App 入口壳（主题、多语言注册、全局状态）
// 作者: testerwm
// 创建: 2026-06-09
// 说明: 所有城市页面共用此 App 壳，
//       新增城市时通常不需修改此文件
// ============================================

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/ty_app_localizations.dart';
import 'shared/ty_colors.dart';

class MyApp extends StatefulWidget {
  /// 起始页面（默认太原，其他成员可替换为自己的城市页）
  final Widget home;

  const MyApp({super.key, this.home = const _DefaultHome()});

  /// 从任意 context 切换语言
  static void setLocale(BuildContext context, Locale locale) {
    context.findAncestorStateOfType<_MyAppState>()?.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('ko'); // 默认韩语
  void setLocale(Locale l) => setState(() => _locale = l);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.red,
          brightness: Brightness.light,
          surface: AppColors.bgCard,
        ),
      ),
      home: widget.home,
    );
  }
}

/// 默认首页占位（由 main.dart 替换为实际城市页）
class _DefaultHome extends StatelessWidget {
  const _DefaultHome();
  @override
  Widget build(BuildContext c) => const Scaffold(body: Center(child: Text('请指定 home 页面')));
}
