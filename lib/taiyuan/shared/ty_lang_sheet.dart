// ============================================
// 文件: lib/shared/ty_lang_sheet.dart
// 用途: 语言选择 Bottom Sheet — 浅色主题 v2
// 作者: testerwm
// 创建: 2026-06-09
// ============================================

import 'package:flutter/material.dart';
import 'ty_colors.dart';
import '../l10n/ty_app_localizations.dart';
import '../ty_app.dart';

void showLangSheet(BuildContext ctx) {
  final l10n = AppLocalizations.of(ctx);
  final cur = Localizations.localeOf(ctx).languageCode;
  showModalBottomSheet(
    context: ctx,
    backgroundColor: AppColors.bgCard,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _LangSheet(cur: cur, l10n: l10n),
  );
}

class _LangSheet extends StatelessWidget {
  final String cur;
  final AppLocalizations l10n;
  const _LangSheet({required this.cur, required this.l10n});

  @override
  Widget build(BuildContext ctx) => Padding(
    padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          l10n['langTitle'],
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _LangOpt(
          flag: '🇨🇳',
          name: l10n['langChinese'],
          native: l10n['langChineseSub'],
          sel: cur == 'zh',
          onTap: () {
            Navigator.pop(ctx);
            MyApp.setLocale(ctx, const Locale('zh'));
          },
        ),
        _LangOpt(
          flag: '🇺🇸',
          name: l10n['langEnglish'],
          native: l10n['langEnglishSub'],
          sel: cur == 'en',
          onTap: () {
            Navigator.pop(ctx);
            MyApp.setLocale(ctx, const Locale('en'));
          },
        ),
        _LangOpt(
          flag: '🇰🇷',
          name: l10n['langKorean'],
          native: l10n['langKoreanSub'],
          sel: cur == 'ko',
          onTap: () {
            Navigator.pop(ctx);
            MyApp.setLocale(ctx, const Locale('ko'));
          },
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}

class _LangOpt extends StatelessWidget {
  final String flag, name, native;
  final bool sel;
  final VoidCallback onTap;
  const _LangOpt({
    required this.flag,
    required this.name,
    required this.native,
    required this.sel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext c) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: sel ? AppColors.goldBorder : Colors.transparent,
          ),
          color: sel ? AppColors.goldBg : Colors.transparent,
        ),
        child: Row(children: [
          Text(flag, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Text(
            name,
            style: TextStyle(
              color: sel ? AppColors.ink : AppColors.ink3,
              fontSize: 13,
              fontWeight: sel ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            native,
            style: const TextStyle(color: AppColors.ink4, fontSize: 10),
          ),
          if (sel) ...[
            const SizedBox(width: 6),
            const Icon(Icons.check_rounded, color: AppColors.gold, size: 18),
          ],
        ]),
      ),
    ),
  );
}
