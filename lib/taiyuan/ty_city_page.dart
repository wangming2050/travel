// ============================================
// 文件: lib/ty_city_page.dart
// 用途: 城市页面框架 — 浅色主题 v2 + 可拖动语言按钮
// 作者: testerwm
// 创建: 2026-06-09
// ============================================

import 'package:flutter/material.dart';
import 'l10n/ty_app_localizations.dart';
import 'shared/ty_colors.dart';
import 'shared/ty_ai_assistant_sheet.dart';
import 'shared/ty_hero_header.dart';
import 'shared/ty_tab_row.dart';
import 'shared/ty_lang_sheet.dart';

class CityPage extends StatefulWidget {
  static final ValueNotifier<int> activeTab = ValueNotifier(0);
  final List<Widget> tabs;
  final List<({Color color, String emoji})> heroBackgrounds;
  final String provinceKey, cityKey, subtitleKey;

  const CityPage({
    required this.tabs,
    required this.heroBackgrounds,
    this.provinceKey = 'heroProvince',
    this.cityKey = 'heroCityName',
    this.subtitleKey = 'heroSubtitle',
  });

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  int _tab = 0;
  late final PageController _pageCtrl = PageController();

  // ── 可拖动语言按钮状态 ──
  double _langX = 0; // 将在 initState 中初始化
  double _langY = 0;
  bool _langReady = false;

  @override
  void initState() {
    super.initState();
    // 延迟计算初始位置（需要 context 获取屏幕尺寸）
    WidgetsBinding.instance.addPostFrameCallback((_) => _initLangPos());
  }

  void _initLangPos() {
    if (!mounted) return;
    final screenW = MediaQuery.of(context).size.width;
    final s = (screenW / 260.0).clamp(1.0, 1.7);
    final emojiSize = 52.0 * s;

    setState(() {
      _langX = screenW - 42;
      _langY = emojiSize + 8; // hero topPad=0，emoji 下方 8px
      _langReady = true;
    });
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tabNames = [
      l10n['tabIntro'],
      l10n['tabSpots'],
      l10n['tabFood'],
      l10n['tabRoute'],
    ];
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // ── 主内容 ──
            Column(
              children: [
                CityHeroHeader(
                  tab: _tab,
                  provinceKey: widget.provinceKey,
                  cityKey: widget.cityKey,
                  subtitleKey: widget.subtitleKey,
                  backgrounds: widget.heroBackgrounds,
                  onLogoTap: () => showTyAiAssistantSheet(context),
                ),
                CityTabRow(
                  tabs: tabNames,
                  pageCtrl: _pageCtrl,
                  onTap: (i) => _pageCtrl.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageCtrl,
                    onPageChanged: (i) => setState(() {
                      _tab = i;
                      CityPage.activeTab.value = i;
                    }),
                    children: widget.tabs,
                  ),
                ),
              ],
            ),
            // ── 可拖动语言按钮 ──
            if (_langReady)
              Positioned(
                left: _langX,
                top: _langY,
                child: GestureDetector(
                  onPanUpdate: (d) {
                    setState(() {
                      _langX = (_langX + d.delta.dx).clamp(
                        4.0,
                        MediaQuery.of(context).size.width - 36,
                      );
                      _langY = (_langY + d.delta.dy).clamp(
                        4.0,
                        MediaQuery.of(context).size.height - 80,
                      );
                    });
                  },
                  onTap: () => showLangSheet(context),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.goldBg,
                      border: Border.all(color: AppColors.goldBorder),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadowLight,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('🌐', style: TextStyle(fontSize: 14)),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
