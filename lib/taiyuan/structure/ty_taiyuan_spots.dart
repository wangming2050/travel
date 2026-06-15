// ============================================
// 文件: lib/taiyuan/structure/ty_taiyuan_spots.dart
// 用途: 太原城市 - 景点 Tab — 真实景点数据 + 可交互筛选
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

// ── 景点数据模型 ──

enum SpotCategory { all, gujian, bowuguan, shiku, gucheng }

extension SpotCategoryExt on SpotCategory {
  String get label {
    switch (this) {
      case SpotCategory.all:
        return '全部';
      case SpotCategory.gujian:
        return '古建';
      case SpotCategory.bowuguan:
        return '博物馆';
      case SpotCategory.shiku:
        return '石窟';
      case SpotCategory.gucheng:
        return '古城';
    }
  }
}

class _SpotItem {
  final String image;
  final String title;
  final String subtitle;
  final String badge;
  final String badgeLabel;
  final String rating;
  final String count;
  final String meta;
  final String desc;
  final List<(String, String)> cells;
  final List<String> tags;
  final SpotCategory category;
  final SpotGalleryData gallery;

  const _SpotItem({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.badgeLabel,
    required this.rating,
    required this.count,
    required this.meta,
    required this.desc,
    required this.cells,
    required this.tags,
    required this.category,
    required this.gallery,
  });
}

// ── 景点数据构建器（从 l10n 获取翻译文案） ──

List<_SpotItem> _buildSpots(AppLocalizations l10n) {
  String g(String k) => l10n[k];

  return [
    // ── 晋祠 ──
    _SpotItem(
      image: 'assets/ty_taiyuan/video/images/taiyuan/jinci.jpg',
      title: g('sp_jinci_title'), subtitle: g('sp_jinci_sub'),
      badge: g('sp_jinci_badge'), badgeLabel: g('sp_jinci_price'),
      rating: g('sp_jinci_rating'), count: g('sp_jinci_count'), meta: g('sp_jinci_meta'),
      desc: g('sp_jinci_desc'),
      cells: [(g('sp_jinci_c0l'), g('sp_jinci_c0v')), (g('sp_jinci_c1l'), g('sp_jinci_c1v')), (g('sp_jinci_c2l'), g('sp_jinci_c2v'))],
      tags: [g('sp_jinci_t0'), g('sp_jinci_t1'), g('sp_jinci_t2')],
      category: SpotCategory.gujian,
      gallery: SpotGalleryData(
        spotName: g('sp_jinci_gname'), spotSubtitle: g('sp_jinci_gsub'),
        images: [
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/jc1.jpg', title: g('sp_jinci_i0t'), subtitle: g('sp_jinci_i0s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/jc2.jpg', title: g('sp_jinci_i1t'), subtitle: g('sp_jinci_i1s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/jc3.jpg', title: g('sp_jinci_i2t'), subtitle: g('sp_jinci_i2s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/jc4.jpg', title: g('sp_jinci_i3t'), subtitle: g('sp_jinci_i3s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/jc5.jpg', title: g('sp_jinci_i4t'), subtitle: g('sp_jinci_i4s')),
        ],
      ),
    ),
    // ── 山西博物院 ──
    _SpotItem(
      image: 'assets/ty_taiyuan/video/images/taiyuan/museum.jpg',
      title: g('sp_museum_title'), subtitle: g('sp_museum_sub'),
      badge: g('sp_museum_badge'), badgeLabel: g('sp_museum_price'),
      rating: g('sp_museum_rating'), count: g('sp_museum_count'), meta: g('sp_museum_meta'),
      desc: g('sp_museum_desc'),
      cells: [(g('sp_museum_c0l'), g('sp_museum_c0v')), (g('sp_museum_c1l'), g('sp_museum_c1v')), (g('sp_museum_c2l'), g('sp_museum_c2v'))],
      tags: [g('sp_museum_t0'), g('sp_museum_t1'), g('sp_museum_t2')],
      category: SpotCategory.bowuguan,
      gallery: SpotGalleryData(
        spotName: g('sp_museum_gname'), spotSubtitle: g('sp_museum_gsub'),
        images: [
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/museum.jpg', title: g('sp_museum_i0t'), subtitle: g('sp_museum_i0s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/museum1.jpg', title: g('sp_museum_i1t'), subtitle: g('sp_museum_i1s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/museum2.jpg', title: g('sp_museum_i2t'), subtitle: g('sp_museum_i2s')),
        ],
      ),
    ),
    // ── 蒙山大佛 ──
    _SpotItem(
      image: 'assets/ty_taiyuan/video/images/taiyuan/ms.jpg',
      title: g('sp_ms_title'), subtitle: g('sp_ms_sub'),
      badge: g('sp_ms_badge'), badgeLabel: g('sp_ms_price'),
      rating: g('sp_ms_rating'), count: g('sp_ms_count'), meta: g('sp_ms_meta'),
      desc: g('sp_ms_desc'),
      cells: [(g('sp_ms_c0l'), g('sp_ms_c0v')), (g('sp_ms_c1l'), g('sp_ms_c1v')), (g('sp_ms_c2l'), g('sp_ms_c2v'))],
      tags: [g('sp_ms_t0'), g('sp_ms_t1'), g('sp_ms_t2')],
      category: SpotCategory.gujian,
      gallery: SpotGalleryData(
        spotName: g('sp_ms_gname'), spotSubtitle: g('sp_ms_gsub'),
        images: [
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/ms.jpg', title: g('sp_ms_i0t'), subtitle: g('sp_ms_i0s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/ms.jpg', title: g('sp_ms_i1t'), subtitle: g('sp_ms_i1s')),
        ],
      ),
    ),
    // ── 太原古县城 ──
    _SpotItem(
      image: 'assets/ty_taiyuan/video/images/taiyuan/gxc.jpg',
      title: g('sp_gxc_title'), subtitle: g('sp_gxc_sub'),
      badge: g('sp_gxc_badge'), badgeLabel: g('sp_gxc_price'),
      rating: g('sp_gxc_rating'), count: g('sp_gxc_count'), meta: g('sp_gxc_meta'),
      desc: g('sp_gxc_desc'),
      cells: [(g('sp_gxc_c0l'), g('sp_gxc_c0v')), (g('sp_gxc_c1l'), g('sp_gxc_c1v')), (g('sp_gxc_c2l'), g('sp_gxc_c2v'))],
      tags: [g('sp_gxc_t0'), g('sp_gxc_t1'), g('sp_gxc_t2')],
      category: SpotCategory.gucheng,
      gallery: SpotGalleryData(
        spotName: g('sp_gxc_gname'), spotSubtitle: g('sp_gxc_gsub'),
        images: [
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/gxc1.jpg', title: g('sp_gxc_i0t'), subtitle: g('sp_gxc_i0s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/gxc2.jpg', title: g('sp_gxc_i1t'), subtitle: g('sp_gxc_i1s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/gxc3.jpg', title: g('sp_gxc_i2t'), subtitle: g('sp_gxc_i2s')),
        ],
      ),
    ),
    // ── 双塔寺 ──
    _SpotItem(
      image: 'assets/ty_taiyuan/video/images/taiyuan/st.jpg',
      title: g('sp_st_title'), subtitle: g('sp_st_sub'),
      badge: g('sp_st_badge'), badgeLabel: g('sp_st_price'),
      rating: g('sp_st_rating'), count: g('sp_st_count'), meta: g('sp_st_meta'),
      desc: g('sp_st_desc'),
      cells: [(g('sp_st_c0l'), g('sp_st_c0v')), (g('sp_st_c1l'), g('sp_st_c1v')), (g('sp_st_c2l'), g('sp_st_c2v'))],
      tags: [g('sp_st_t0'), g('sp_st_t1'), g('sp_st_t2')],
      category: SpotCategory.gujian,
      gallery: SpotGalleryData(
        spotName: g('sp_st_gname'), spotSubtitle: g('sp_st_gsub'),
        images: [
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/st.jpg', title: g('sp_st_i0t'), subtitle: g('sp_st_i0s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/st.jpg', title: g('sp_st_i1t'), subtitle: g('sp_st_i1s')),
        ],
      ),
    ),
    // ── 天龙山石窟 ──
    _SpotItem(
      image: 'assets/ty_taiyuan/video/images/taiyuan/tls.jpg',
      title: g('sp_tls_title'), subtitle: g('sp_tls_sub'),
      badge: g('sp_tls_badge'), badgeLabel: g('sp_tls_price'),
      rating: g('sp_tls_rating'), count: g('sp_tls_count'), meta: g('sp_tls_meta'),
      desc: g('sp_tls_desc'),
      cells: [(g('sp_tls_c0l'), g('sp_tls_c0v')), (g('sp_tls_c1l'), g('sp_tls_c1v')), (g('sp_tls_c2l'), g('sp_tls_c2v'))],
      tags: [g('sp_tls_t0'), g('sp_tls_t1'), g('sp_tls_t2')],
      category: SpotCategory.shiku,
      gallery: SpotGalleryData(
        spotName: g('sp_tls_gname'), spotSubtitle: g('sp_tls_gsub'),
        images: [
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/tls.jpg', title: g('sp_tls_i0t'), subtitle: g('sp_tls_i0s')),
          GalleryImage(assetPath: 'assets/ty_taiyuan/video/images/taiyuan/tls.jpg', title: g('sp_tls_i1t'), subtitle: g('sp_tls_i1s')),
        ],
      ),
    ),
  ];
}

// ── 景点 Tab ──

class TaiyuanSpotsTab extends StatefulWidget {
  const TaiyuanSpotsTab({super.key});

  @override
  State<TaiyuanSpotsTab> createState() => _TaiyuanSpotsTabState();
}

class _TaiyuanSpotsTabState extends State<TaiyuanSpotsTab> {
  SpotCategory _selectedFilter = SpotCategory.all;

  List<_SpotItem> _filteredSpots(AppLocalizations l10n) {
    final all = _buildSpots(l10n);
    if (_selectedFilter == SpotCategory.all) return all;
    return all.where((s) => s.category == _selectedFilter).toList();
  }

  void _onFilterChanged(SpotCategory category) {
    setState(() => _selectedFilter = category);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final spots = _filteredSpots(l10n);

    return ListView(
      padding: const EdgeInsets.only(bottom: 20),
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 14),
        _SpotFilterRow(
          selected: _selectedFilter,
          onChanged: _onFilterChanged,
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              for (int i = 0; i < spots.length; i++) ...[
                _FeatureSpotCard(
                  image: spots[i].image,
                  title: spots[i].title,
                  subtitle: spots[i].subtitle,
                  badge: spots[i].badge,
                  price: spots[i].badgeLabel,
                  rating: spots[i].rating,
                  count: spots[i].count,
                  meta: spots[i].meta,
                  desc: spots[i].desc,
                  cells: spots[i].cells,
                  tags: spots[i].tags,
                  onTap: () => openSpotGallery(context, spots[i].gallery),
                ),
                if (i < spots.length - 1) const SizedBox(height: 12),
              ],
              if (spots.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text(l10n['lbl_empty_spots'],
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

String _spotCatKey(SpotCategory cat) {
  switch (cat) {
    case SpotCategory.all: return 'cat_all';
    case SpotCategory.gujian: return 'cat_gujian';
    case SpotCategory.bowuguan: return 'cat_bowuguan';
    case SpotCategory.shiku: return 'cat_shiku';
    case SpotCategory.gucheng: return 'cat_gucheng';
  }
}

class _SpotFilterRow extends StatelessWidget {
  final SpotCategory selected;
  final ValueChanged<SpotCategory> onChanged;

  const _SpotFilterRow({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const categories = SpotCategory.values;

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
                l10n[_spotCatKey(cat)],
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

// ── 景点卡片（复用原版） ──

class _FeatureSpotCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String badge;
  final String price;
  final String rating;
  final String count;
  final String meta;
  final String desc;
  final List<(String, String)> cells;
  final List<String> tags;
  final VoidCallback onTap;

  const _FeatureSpotCard({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.price,
    required this.rating,
    required this.count,
    required this.meta,
    required this.desc,
    required this.cells,
    required this.tags,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => HapticTap(
        onTap: onTap,
        child: Container(
          decoration: cardDecoration(radius: 20),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 196,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      image,
                      fit: BoxFit.cover,
                      alignment: const Alignment(0, -0.24),
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x101E1810),
                            Color(0x001E1810),
                            Color(0xB31E1810),
                          ],
                          stops: [0, 0.48, 1],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: _ImageBadge(text: badge, color: AppColors.gold),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: _ImageBadge(text: price, color: AppColors.red),
                    ),
                    Positioned(
                      left: 14,
                      right: 14,
                      bottom: 14,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subtitle,
                            style: const TextStyle(
                              color: Color(0xDDF9F2E7),
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFFF9F2E7),
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              height: 1.05,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.ink,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          meta,
                          style: const TextStyle(
                            color: AppColors.ink4,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          '★★★★★',
                          style: TextStyle(
                            color: AppColors.gold2,
                            fontSize: 10,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          rating,
                          style: const TextStyle(
                            color: AppColors.gold,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '· $count',
                          style: const TextStyle(
                            color: AppColors.ink4,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Text(
                      desc,
                      style: const TextStyle(
                        color: AppColors.ink3,
                        fontSize: 11,
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: cells
                          .map(
                            (cell) => Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: cell == cells.last ? 0 : 7),
                                child:
                                    _GuideCell(label: cell.$1, value: cell.$2),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: tags
                          .map((tag) => AccentPill(
                                tag,
                                highlight: tag.contains('免费') ||
                                    tag.contains('千年') ||
                                    tag == '满江红取景地',
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class _ImageBadge extends StatelessWidget {
  final String text;
  final Color color;
  const _ImageBadge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                color: Color(0x331E1810),
                blurRadius: 8,
                offset: Offset(0, 2)),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
      );
}

class _GuideCell extends StatelessWidget {
  final String label;
  final String value;
  const _GuideCell({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.bgCard2,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.ink4, fontSize: 9),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.ink2,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      );
}
