// ============================================
// 文件: lib/taiyuan/structure/ty_taiyuan_food.dart
// 用途: 太原城市 - 美食 Tab — 真实美食数据 + 可交互筛选
// 作者: testerwm + Claude
// 创建: 2026-06-09 / 更新: 2026-06-13
// 说明: 点击卡片 → 全屏图集（上下滑动看图，右滑返回列表）
//       筛选器可点击切换分类，实际过滤列表
// ============================================

import 'package:flutter/material.dart';
import '../l10n/ty_app_localizations.dart';
import '../shared/ty_colors.dart';
import '../shared/ty_spot_gallery.dart';
import '../shared/ty_widgets.dart';

// ── 美食数据模型 ──

enum FoodCategory { all, mianshi, roushi, xiaochi, tanglei }

extension FoodCategoryExt on FoodCategory {
  String get label {
    switch (this) {
      case FoodCategory.all:
        return '全部';
      case FoodCategory.mianshi:
        return '面食';
      case FoodCategory.roushi:
        return '肉食';
      case FoodCategory.xiaochi:
        return '小吃';
      case FoodCategory.tanglei:
        return '汤类';
    }
  }
}

class _FoodItem {
  final String image;
  final String? badge;
  final Color? badgeColor;
  final String title;
  final String desc;
  final String note;
  final int heat;
  final FoodCategory category;
  final SpotGalleryData gallery;

  const _FoodItem({
    required this.image,
    this.badge,
    this.badgeColor,
    required this.title,
    required this.desc,
    required this.note,
    required this.heat,
    required this.category,
    required this.gallery,
  });
}

// ── 美食数据构建器（从 l10n 获取翻译文案） ──

List<_FoodItem> _buildFoods(AppLocalizations l10n) {
  String g(String k) => l10n[k];
  String? gn(String k) => l10n[k].isEmpty ? null : l10n[k];

  return [
    _FoodItem(
      image: 'assets/ty_taiyuan/video/images/taiyuan/noodle.jpg',
      badge: gn('fd_daoxiao_badge'),
      title: g('fd_daoxiao_title'), desc: g('fd_daoxiao_desc'), note: g('fd_daoxiao_note'),
      heat: 5, category: FoodCategory.mianshi,
      gallery: SpotGalleryData(
        spotName: g('fd_daoxiao_gname'), spotSubtitle: g('fd_daoxiao_gsub'),
        images: [
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/noodle.jpg', title: g('fd_daoxiao_i0t'), subtitle: g('fd_daoxiao_i0s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/noodle1.jpg', title: g('fd_daoxiao_i1t'), subtitle: g('fd_daoxiao_i1s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/noodle2.jpg', title: g('fd_daoxiao_i2t'), subtitle: g('fd_daoxiao_i2s')),
        ],
      ),
    ),
    _FoodItem(
      image: 'assets/ty_taiyuan/video/images/taiyuan/gyr.jpg',
      badge: gn('fd_gyr_badge'), badgeColor: AppColors.gold,
      title: g('fd_gyr_title'), desc: g('fd_gyr_desc'), note: g('fd_gyr_note'),
      heat: 5, category: FoodCategory.roushi,
      gallery: SpotGalleryData(
        spotName: g('fd_gyr_gname'), spotSubtitle: g('fd_gyr_gsub'),
        images: [
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/gyr.jpg', title: g('fd_gyr_i0t'), subtitle: g('fd_gyr_i0s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/gyr.jpg', title: g('fd_gyr_i1t'), subtitle: g('fd_gyr_i1s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/gyr.jpg', title: g('fd_gyr_i2t'), subtitle: g('fd_gyr_i2s')),
        ],
      ),
    ),
    _FoodItem(
      image: 'assets/ty_taiyuan/video/images/taiyuan/tn.jpg',
      badge: gn('fd_tn_badge'),
      title: g('fd_tn_title'), desc: g('fd_tn_desc'), note: g('fd_tn_note'),
      heat: 4, category: FoodCategory.tanglei,
      gallery: SpotGalleryData(
        spotName: g('fd_tn_gname'), spotSubtitle: g('fd_tn_gsub'),
        images: [
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/tn.jpg', title: g('fd_tn_i0t'), subtitle: g('fd_tn_i0s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/tn.jpg', title: g('fd_tn_i1t'), subtitle: g('fd_tn_i1s')),
        ],
      ),
    ),
    _FoodItem(
      image: 'assets/ty_taiyuan/video/images/taiyuan/yzg.jpg',
      badge: gn('fd_yzg_badge'),
      title: g('fd_yzg_title'), desc: g('fd_yzg_desc'), note: g('fd_yzg_note'),
      heat: 4, category: FoodCategory.tanglei,
      gallery: SpotGalleryData(
        spotName: g('fd_yzg_gname'), spotSubtitle: g('fd_yzg_gsub'),
        images: [
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/yzg.jpg', title: g('fd_yzg_i0t'), subtitle: g('fd_yzg_i0s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/yzg.jpg', title: g('fd_yzg_i1t'), subtitle: g('fd_yzg_i1s')),
        ],
      ),
    ),
    _FoodItem(
      image: 'assets/ty_taiyuan/video/images/taiyuan/kll.jpg',
      badge: gn('fd_kll_badge'),
      title: g('fd_kll_title'), desc: g('fd_kll_desc'), note: g('fd_kll_note'),
      heat: 4, category: FoodCategory.mianshi,
      gallery: SpotGalleryData(
        spotName: g('fd_kll_gname'), spotSubtitle: g('fd_kll_gsub'),
        images: [
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/kll.jpg', title: g('fd_kll_i0t'), subtitle: g('fd_kll_i0s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/kll.jpg', title: g('fd_kll_i1t'), subtitle: g('fd_kll_i1s')),
        ],
      ),
    ),
    _FoodItem(
      image: 'assets/ty_taiyuan/video/images/taiyuan/gc1.jpg',
      badge: gn('fd_gc_badge'),
      title: g('fd_gc_title'), desc: g('fd_gc_desc'), note: g('fd_gc_note'),
      heat: 3, category: FoodCategory.xiaochi,
      gallery: SpotGalleryData(
        spotName: g('fd_gc_gname'), spotSubtitle: g('fd_gc_gsub'),
        images: [
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/gc1.jpg', title: g('fd_gc_i0t'), subtitle: g('fd_gc_i0s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/gc1.jpg', title: g('fd_gc_i1t'), subtitle: g('fd_gc_i1s')),
        ],
      ),
    ),
    _FoodItem(
      image: 'assets/ty_taiyuan/video/images/taiyuan/sm1.jpg',
      badge: gn('fd_sm_badge'),
      title: g('fd_sm_title'), desc: g('fd_sm_desc'), note: g('fd_sm_note'),
      heat: 4, category: FoodCategory.xiaochi,
      gallery: SpotGalleryData(
        spotName: g('fd_sm_gname'), spotSubtitle: g('fd_sm_gsub'),
        images: [
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/sm1.jpg', title: g('fd_sm_i0t'), subtitle: g('fd_sm_i0s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/sm1.jpg', title: g('fd_sm_i1t'), subtitle: g('fd_sm_i1s')),
        ],
      ),
    ),
    _FoodItem(
      image: 'assets/ty_taiyuan/video/images/taiyuan/jr.jpg',
      badge: gn('fd_jr_badge'), badgeColor: AppColors.gold,
      title: g('fd_jr_title'), desc: g('fd_jr_desc'), note: g('fd_jr_note'),
      heat: 3, category: FoodCategory.roushi,
      gallery: SpotGalleryData(
        spotName: g('fd_jr_gname'), spotSubtitle: g('fd_jr_gsub'),
        images: [
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/jr.jpg', title: g('fd_jr_i0t'), subtitle: g('fd_jr_i0s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/jr.jpg', title: g('fd_jr_i1t'), subtitle: g('fd_jr_i1s')),
        ],
      ),
    ),
  ];
}

// ── 美食 Tab ──

class TaiyuanFoodTab extends StatefulWidget {
  const TaiyuanFoodTab({super.key});

  @override
  State<TaiyuanFoodTab> createState() => _TaiyuanFoodTabState();
}

class _TaiyuanFoodTabState extends State<TaiyuanFoodTab> {
  FoodCategory _selectedFilter = FoodCategory.all;

  List<_FoodItem> _filteredFoods(AppLocalizations l10n) {
    final all = _buildFoods(l10n);
    if (_selectedFilter == FoodCategory.all) return all;
    return all.where((f) => f.category == _selectedFilter).toList();
  }

  void _onFilterChanged(FoodCategory category) {
    setState(() => _selectedFilter = category);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final foods = _filteredFoods(l10n);

    return ListView(
      padding: const EdgeInsets.only(bottom: 20),
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 14),
        _FoodFilterRow(
          selected: _selectedFilter,
          onChanged: _onFilterChanged,
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              for (int i = 0; i < foods.length; i++) ...[
                _FoodListCard(
                  image: foods[i].image,
                  badge: foods[i].badge,
                  badgeColor: foods[i].badgeColor,
                  title: foods[i].title,
                  desc: foods[i].desc,
                  note: foods[i].note,
                  heat: foods[i].heat,
                  onTap: () => openSpotGallery(context, foods[i].gallery),
                ),
                if (i < foods.length - 1) const SizedBox(height: 10),
              ],
              if (foods.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text(l10n['lbl_empty_food'],
                        style: const TextStyle(color: AppColors.ink4, fontSize: 13)),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── 筛选器 ──

String _foodCatKey(FoodCategory cat) {
  switch (cat) {
    case FoodCategory.all: return 'cat_all';
    case FoodCategory.mianshi: return 'cat_mianshi';
    case FoodCategory.roushi: return 'cat_roushi';
    case FoodCategory.xiaochi: return 'cat_xiaochi';
    case FoodCategory.tanglei: return 'cat_tanglei';
  }
}

class _FoodFilterRow extends StatelessWidget {
  final FoodCategory selected;
  final ValueChanged<FoodCategory> onChanged;

  const _FoodFilterRow({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const categories = FoodCategory.values;

    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = cat == selected;
          return GestureDetector(
            onTap: () => onChanged(cat),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.red : AppColors.bgCard,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                    color: isSelected ? AppColors.red : AppColors.border2),
                boxShadow: const [
                  BoxShadow(
                      color: AppColors.shadowLight,
                      blurRadius: 8,
                      offset: Offset(0, 2)),
                ],
              ),
              child: Text(
                l10n[_foodCatKey(cat)],
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.ink2,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: categories.length,
      ),
    );
  }
}

// ── 美食卡片 ──

class _FoodListCard extends StatelessWidget {
  final String image;
  final String? badge;
  final String title;
  final String desc;
  final String note;
  final int heat;
  final Color? badgeColor;
  final VoidCallback onTap;

  const _FoodListCard({
    required this.image,
    this.badge,
    required this.title,
    required this.desc,
    required this.note,
    required this.heat,
    this.badgeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => HapticTap(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 148),
          decoration: cardDecoration(radius: 18),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              SizedBox(
                width: 136,
                height: 148,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      image,
                      fit: BoxFit.cover,
                      alignment: const Alignment(-0.08, -0.18),
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0x001E1810), Color(0x22FFFFFF)],
                        ),
                      ),
                    ),
                    if (badge != null)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                            color: badgeColor ?? AppColors.red,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0x331E1810),
                                  blurRadius: 7,
                                  offset: Offset(0, 2)),
                            ],
                          ),
                          child: Text(
                            badge!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        desc,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.ink3,
                          fontSize: 11,
                          height: 1.42,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        note,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: List.generate(5, (i) {
                          final active = i < heat;
                          return Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: active
                                  ? AppColors.red2
                                  : AppColors.border,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

// Keep the private FoodCategory enum locally scoped
