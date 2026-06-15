// ============================================
// 文件: lib/shared/ty_tab_row.dart
// 用途: Tab 栏 — 与设计稿一致：18px 内边距 + 浅色非激活文字 + 红色指示条
// 作者: testerwm
// 创建: 2026-06-09
// ============================================

import 'package:flutter/material.dart';
import 'ty_colors.dart';

/// 非激活 Tab 颜色 — 与设计稿 #A89E90 一致
const _tabInactive = AppColors.ink3; // #5E5248

class CityTabRow extends StatefulWidget {
  final List<String> tabs;
  final PageController pageCtrl;
  final ValueChanged<int> onTap;

  const CityTabRow({
    required this.tabs,
    required this.pageCtrl,
    required this.onTap,
  });

  @override
  State<CityTabRow> createState() => _CityTabRowState();
}

class _CityTabRowState extends State<CityTabRow> {
  double _page = 0;

  @override
  void initState() {
    super.initState();
    _page = widget.pageCtrl.initialPage.toDouble();
    widget.pageCtrl.addListener(_onPage);
  }

  void _onPage() {
    final p = widget.pageCtrl.page ?? 0;
    if (p != _page && mounted) setState(() => _page = p);
  }

  @override
  void dispose() {
    widget.pageCtrl.removeListener(_onPage);
    super.dispose();
  }

  @override
  Widget build(BuildContext c) => Container(
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: AppColors.border, width: 1.5),
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 18),
    child: LayoutBuilder(builder: (c, cons) {
      final tabW = cons.maxWidth / widget.tabs.length;
      return SizedBox(
        height: 44,
        child: Stack(children: [
          Row(children: [
            for (int i = 0; i < widget.tabs.length; i++)
              _tab(widget.tabs[i], i, tabW),
          ]),
          // 红色指示条
          Positioned(
            bottom: 0,
            left: _page * tabW + tabW * 0.15,
            width: tabW * 0.7,
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ]),
      );
    }),
  );

  Widget _tab(String text, int i, double tabW) => Expanded(
    child: GestureDetector(
      onTap: () => widget.onTap(i),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 9),
        alignment: Alignment.center,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: (_page - i).abs() < 0.5 ? AppColors.red : _tabInactive,
            fontSize: 13,
            fontWeight: (_page - i).abs() < 0.5
                ? FontWeight.w600
                : FontWeight.w400,
          ),
          child: Text(text),
        ),
      ),
    ),
  );
}
