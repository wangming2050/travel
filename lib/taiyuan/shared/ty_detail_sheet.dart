// ============================================
// 文件: lib/shared/ty_detail_sheet.dart
// 用途: 景点/美食详情 Bottom Sheet — 浅色主题 v2
// 作者: testerwm
// 创建: 2026-06-09
// ============================================

import 'package:flutter/material.dart';
import 'ty_colors.dart';
import '../l10n/ty_app_localizations.dart';

void showSpotDetail(BuildContext c, String key, String emoji) {
  final l10n = AppLocalizations.of(c);
  showModalBottomSheet(
    context: c,
    backgroundColor: AppColors.bgCard,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _DetailSheet(
      emoji: emoji,
      title: l10n[key],
      desc: l10n['${key}Desc'],
      rows: [
        ('🕐', l10n['detailHours'], l10n['${key}Hours']),
        ('📍', l10n['detailLocation'], l10n['${key}Loc']),
        ('💡', l10n['detailTip'], l10n['${key}Tip']),
      ],
    ),
  );
}

void showFoodDetail(BuildContext c, String key, String emoji) {
  final l10n = AppLocalizations.of(c);
  showModalBottomSheet(
    context: c,
    backgroundColor: AppColors.bgCard,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _DetailSheet(
      emoji: emoji,
      title: l10n[key],
      desc: l10n['${key}Desc'],
      rows: [
        ('🏠', l10n['detailRecommend'], l10n['${key}Rec']),
        ('💰', l10n['detailPrice'], l10n['${key}Price']),
      ],
    ),
  );
}

class _DetailSheet extends StatelessWidget {
  final String emoji, title, desc;
  final List<(String, String, String)> rows;
  const _DetailSheet({
    required this.emoji,
    required this.title,
    required this.desc,
    required this.rows,
  });

  @override
  Widget build(BuildContext c) => Padding(
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
        const SizedBox(height: 16),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.goldBg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 30)),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            desc,
            style: const TextStyle(
              color: AppColors.ink3,
              fontSize: 12,
              height: 1.7,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: rows
                .map((r) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r.$1, style: const TextStyle(fontSize: 14)),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 56,
                            child: Text(
                              r.$2,
                              style: const TextStyle(
                                color: AppColors.ink4,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              r.$3,
                              style: const TextStyle(
                                color: AppColors.ink2,
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}
