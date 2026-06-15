// ============================================
// 文件: lib/shared/ty_hero_header.dart
// 用途: 城市页顶部 Hero — 按设计稿比例缩放
// 作者: testerwm
// 创建: 2026-06-09
// 说明: 基于设计稿 260px 宽设备，按 screenW/260 等比缩放
// ============================================

import 'package:flutter/material.dart';
import 'ty_colors.dart';
import '../l10n/ty_app_localizations.dart';

class CityHeroHeader extends StatelessWidget {
  final int tab;
  final String provinceKey, cityKey, subtitleKey;
  final List<({Color color, String emoji})> backgrounds;
  final VoidCallback? onLogoTap;

  const CityHeroHeader({
    required this.tab,
    this.provinceKey = 'heroProvince',
    this.cityKey = 'heroCityName',
    this.subtitleKey = 'heroSubtitle',
    required this.backgrounds,
    this.onLogoTap,
  });

  @override
  Widget build(BuildContext c) {
    final l10n = AppLocalizations.of(c);
    final d = backgrounds[tab.clamp(0, backgrounds.length - 1)];
    final screenW = MediaQuery.of(c).size.width;

    // 设计稿基准: device 260px → 按比例缩放
    final s = (screenW / 260.0).clamp(1.0, 1.7); // 缩放比
    final emojiSize = 52.0 * s; // 设计稿 52px
    final citySize = 34.0 * s; // 设计稿 34px
    final pillFont = (10.0 * s).clamp(10.0, 13.0);
    final sloganFont = (11.0 * s).clamp(11.0, 13.0);
    final gapPill = 6.0; // 设计稿 6px
    final gapSlogan = 4.0; // 设计稿 4px
    final topPad = 0.0; // SafeArea 处理系统间距，无需额外 padding
    final bottomPad = 14.0; // 固定 14px，与设计稿一致

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.lerp(AppColors.bg, AppColors.bgCard2, 0.5)!,
            AppColors.bg,
          ],
        ),
      ),
      padding: EdgeInsets.fromLTRB(18, topPad, 18, bottomPad),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 左侧文字
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _ScaledPill(text: l10n[provinceKey], fontSize: pillFont),
                SizedBox(height: gapPill),
                Text(
                  l10n[cityKey],
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: citySize,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3.0 * s,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: gapSlogan),
                Text(
                  l10n[subtitleKey],
                  style: TextStyle(
                    color: AppColors.ink3,
                    fontSize: sloganFont,
                    letterSpacing: 0.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: (18.0 * s).clamp(10.0, 24.0)),
          // 右侧 Emoji — 与 Pill 对齐
          Semantics(
            button: onLogoTap != null,
            label: '打开旅行助手',
            child: GestureDetector(
              key: const ValueKey('taiyuanCityLogoButton'),
              onTap: onLogoTap,
              child: MouseRegion(
                cursor: onLogoTap == null
                    ? SystemMouseCursors.basic
                    : SystemMouseCursors.click,
                child: Text(d.emoji, style: TextStyle(fontSize: emojiSize)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 等比例缩放的 Pill
class _ScaledPill extends StatelessWidget {
  final String text;
  final double fontSize;
  const _ScaledPill({required this.text, required this.fontSize});

  @override
  Widget build(BuildContext c) => Container(
    padding: EdgeInsets.symmetric(
      horizontal: fontSize * 1.2,
      vertical: fontSize * 0.3,
    ),
    decoration: BoxDecoration(
      color: AppColors.goldBg,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: AppColors.goldBorder),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: AppColors.gold,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
