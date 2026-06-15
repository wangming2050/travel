// ============================================
// 文件: lib/l10n/ty_app_localizations.dart
// 用途: 翻译代理类 + LocalizationsDelegate（共用框架）
// 作者: testerwm
// 创建: 2026-06-09
// 说明: 所有城市共用，通过 key 前缀区分城市专属内容
//       新增城市时在对应语言文件追加 key 即可
// ============================================

import 'package:flutter/material.dart';
import 'ty_app_localizations_zh.dart';
import 'ty_app_localizations_en.dart';
import 'ty_app_localizations_ko.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  /// 根据 context 获取翻译实例
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  /// 获取翻译文本（key 不存在时返回 key 本身）
  String get(String key) {
    final map = _translations[locale.languageCode] ?? zhTranslations;
    return map[key] ?? key;
  }

  /// 便捷访问：l10n.key 等同于 l10n.get('key')
  String operator [](String key) => get(key);

  /// 所有语言翻译表
  static const Map<String, Map<String, String>> _translations = {
    'zh': zhTranslations,
    'en': enTranslations,
    'ko': koTranslations,
  };

  /// 支持的语言列表
  static const List<Locale> supportedLocales = [
    Locale('zh'),
    Locale('en'),
    Locale('ko'),
  ];

  /// LocalizationsDelegate
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['zh', 'en', 'ko'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
