// ============================================
// 文件: lib/shared/ty_widgets.dart
// 用途: 共用 UI 组件 — 浅色主题 v2
// 作者: testerwm
// 创建: 2026-06-09
// 说明: 白色卡片 + 砖红强调 + 晋商金点缀
// ============================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ty_colors.dart';

// ── 卡片装饰（白色 + 阴影 + 细边框） ──

BoxDecoration cardDecoration({double radius = 14}) {
  return BoxDecoration(
    color: AppColors.bgCard,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: AppColors.border2),
    boxShadow: const [
      BoxShadow(
        color: AppColors.shadowLight,
        blurRadius: 12,
        offset: Offset(0, 2),
      ),
    ],
  );
}

// ── 标签 ──

class AccentPill extends StatelessWidget {
  final String text;
  final bool highlight;
  const AccentPill(this.text, {this.highlight = true});

  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: highlight ? AppColors.goldBg : AppColors.bgCard,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(
        color: highlight ? AppColors.goldBorder : AppColors.border,
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: highlight ? AppColors.gold : AppColors.ink3,
        fontSize: 10,
        fontWeight: highlight ? FontWeight.w500 : FontWeight.w400,
      ),
    ),
  );
}

/// 兼容旧名
class GoldPill extends StatelessWidget {
  final String text;
  const GoldPill(this.text);

  @override
  Widget build(BuildContext c) => AccentPill(text);
}

class DimPill extends StatelessWidget {
  final String text;
  const DimPill(this.text);

  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: AppColors.bgCard,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: AppColors.border),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: AppColors.ink3,
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

// ── 标题 ──

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text);

  @override
  Widget build(BuildContext c) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        color: AppColors.ink,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
    ),
  );
}

// ── 统计卡片 ──

class StatTile extends StatelessWidget {
  final String value, label;
  const StatTile({required this.value, required this.label});

  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    decoration: cardDecoration(),
    child: Column(children: [
      Text(
        value,
        maxLines: 1,
        style: const TextStyle(
          color: AppColors.red,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          height: 1.2,
        ),
      ),
      const SizedBox(height: 2),
      Text(
        label,
        maxLines: 1,
        style: const TextStyle(
          color: AppColors.ink4,
          fontSize: 9,
        ),
      ),
    ]),
  );
}

class StatsRow extends StatelessWidget {
  final (String, String) s1, s2, s3;
  const StatsRow({required this.s1, required this.s2, required this.s3});

  @override
  Widget build(BuildContext c) => Row(children: [
    Expanded(child: StatTile(value: s1.$1, label: s1.$2)),
    const SizedBox(width: 8),
    Expanded(child: StatTile(value: s2.$1, label: s2.$2)),
    const SizedBox(width: 8),
    Expanded(child: StatTile(value: s3.$1, label: s3.$2)),
  ]);
}

// ── 信息卡片 ──

class InfoTile extends StatelessWidget {
  final String label, value;
  const InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    decoration: cardDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(color: AppColors.ink4, fontSize: 9)),
        const SizedBox(height: 3),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class InfoGrid extends StatelessWidget {
  final InfoTile t1, t2;
  const InfoGrid({required this.t1, required this.t2});

  @override
  Widget build(BuildContext c) => LayoutBuilder(builder: (c, cons) {
    final two = cons.maxWidth >= 360;
    return GridView.count(
      crossAxisCount: two ? 2 : 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: two ? 2.2 : 4.0,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [t1, t2],
    );
  });
}

// ── 文本块 ──

class TextBlock extends StatelessWidget {
  final String text;
  const TextBlock(this.text);

  @override
  Widget build(BuildContext c) => Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
    decoration: cardDecoration(),
    child: Text(
      text,
      style: const TextStyle(
        color: AppColors.ink3,
        fontSize: 11,
        height: 1.6,
      ),
    ),
  );
}

// ── 触觉反馈 ──

class HapticTap extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const HapticTap({required this.onTap, required this.child});

  @override
  Widget build(BuildContext c) => GestureDetector(
    onTap: () {
      HapticFeedback.lightImpact();
      onTap();
    },
    child: child,
  );
}

// ── 占位图（浅色版） ──

class PlaceholderImage extends StatelessWidget {
  final String emoji;
  final double height;
  final Color bg;
  final double radius;
  const PlaceholderImage({
    required this.emoji,
    required this.height,
    required this.bg,
    this.radius = 14,
  });

  @override
  Widget build(BuildContext c) => Container(
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [bg, Color.lerp(bg, const Color(0xFF3D3528), 0.18)!],
      ),
    ),
    clipBehavior: Clip.antiAlias,
    child: Center(
      child: Text(emoji, style: TextStyle(fontSize: height * 0.5)),
    ),
  );
}

// ── 景点卡片（横向滚动） ──

class SpotCard extends StatelessWidget {
  final String emoji, name, badge, price, tag;
  final Color bg;
  const SpotCard({
    required this.emoji,
    required this.bg,
    required this.name,
    required this.badge,
    required this.price,
    required this.tag,
  });

  @override
  Widget build(BuildContext c) => Container(
    width: 130,
    margin: const EdgeInsets.only(right: 10),
    decoration: cardDecoration(radius: 14),
    clipBehavior: Clip.antiAlias,
    child: Column(children: [
      Stack(children: [
        PlaceholderImage(emoji: emoji, height: 88, bg: bg),
        if (badge.isNotEmpty)
          Positioned(
            top: 7,
            right: 7,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
      ]),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Row(children: [
              Text(
                price,
                style: const TextStyle(
                  color: AppColors.red,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                tag,
                style: const TextStyle(color: AppColors.ink4, fontSize: 9),
              ),
            ]),
          ],
        ),
      ),
    ]),
  );
}

// ── 美食卡片（网格） ──

class FoodCard extends StatelessWidget {
  final String emoji, name, sub;
  final Color bg;
  final int heat, delay;
  const FoodCard({
    required this.emoji,
    required this.bg,
    required this.name,
    required this.sub,
    required this.heat,
    required this.delay,
  });

  @override
  Widget build(BuildContext c) => Container(
    decoration: cardDecoration(radius: 14),
    clipBehavior: Clip.antiAlias,
    child: Column(children: [
      PlaceholderImage(emoji: emoji, height: 80, bg: bg),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              sub,
              style: const TextStyle(color: AppColors.ink3, fontSize: 9),
            ),
            const SizedBox(height: 6),
            Row(
              children: List.generate(5, (i) {
                final active = i < heat;
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 180 + delay + i * 40),
                  builder: (_, v, child) => Opacity(
                    opacity: active ? v : 0.15,
                    child: Transform.scale(
                      scale: active ? 0.6 + v * 0.4 : 1.0,
                      child: child,
                    ),
                  ),
                  child: Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(right: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: active
                          ? AppColors.red2
                          : AppColors.border,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    ]),
  );
}

// ── 路线步骤点 ──

class RouteStepDot extends StatelessWidget {
  final int step;
  const RouteStepDot(this.step);

  @override
  Widget build(BuildContext c) => Container(
    width: 24,
    height: 24,
    decoration: BoxDecoration(
      color: AppColors.red,
      shape: BoxShape.circle,
      boxShadow: const [
        BoxShadow(
          color: Color(0x59B84C2E),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Center(
      child: Text(
        '$step',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

/// 虚线（用 dashed border 模拟）
class DashedLine extends StatelessWidget {
  final double height;
  const DashedLine({this.height = 32});

  @override
  Widget build(BuildContext c) => Container(
    width: 2,
    height: height,
    margin: const EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.red2,
          AppColors.red2,
          Colors.transparent,
          Colors.transparent,
        ],
        stops: [0.0, 0.5, 0.5, 1.0],
      ),
    ),
  );
}
