// ============================================
// 文件: lib/taiyuan/shared/ty_spot_gallery.dart
// 用途: 景点全屏图集详情页 — 上下滑动看图，右滑返回列表
// 作者: testerwm + Claude
// 创建: 2026-06-13
// 说明: 深色全屏沉浸浏览，垂直滑动切换图片，水平右滑返回
// ============================================

import 'package:flutter/material.dart';

/// 单张图集图片的数据模型
class GalleryImage {
  final String assetPath;
  final String title;
  final String subtitle;

  const GalleryImage({
    required this.assetPath,
    required this.title,
    this.subtitle = '',
  });
}

/// 景点图集数据模型
class SpotGalleryData {
  final String spotName;
  final String spotSubtitle;
  final List<GalleryImage> images;

  const SpotGalleryData({
    required this.spotName,
    required this.spotSubtitle,
    required this.images,
  });
}

/// 打开景点全屏图集页面
/// 调用方式: Navigator.of(context).push(...) 或直接调用此函数
void openSpotGallery(BuildContext context, SpotGalleryData data) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: true,
      transitionDuration: const Duration(milliseconds: 320),
      reverseTransitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (context, animation, secondaryAnimation) =>
          _SpotGalleryPage(data: data),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // 从右滑入 / 向右滑出的过渡动画
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          )),
          child: child,
        );
      },
    ),
  );
}

// ── 全屏图集页面 ──

class _SpotGalleryPage extends StatefulWidget {
  final SpotGalleryData data;

  const _SpotGalleryPage({required this.data});

  @override
  State<_SpotGalleryPage> createState() => _SpotGalleryPageState();
}

class _SpotGalleryPageState extends State<_SpotGalleryPage> {
  late PageController _pageController;
  int _currentPage = 0;

  /// 用于检测水平拖拽手势（右滑返回）
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  void _popWithSlide() {
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.data.images;
    final total = images.length;

    return Scaffold(
      backgroundColor: const Color(0xFF11100E),
      body: GestureDetector(
        // 检测水平拖拽：水平位移 > 垂直位移 + 30px 阈值 → 右滑返回
        onHorizontalDragStart: (_) {
          _isDragging = true;
        },
        onHorizontalDragUpdate: (details) {
          // 空实现，仅占用手势槽位以阻止与 PageView 冲突
        },
        onHorizontalDragEnd: (details) {
          if (!_isDragging) return;
          _isDragging = false;

          final velocity = details.primaryVelocity ?? 0;
          // velocity > 0 表示向右滑动（手指从左往右）
          if (velocity > 300) {
            _popWithSlide();
          }
        },
        onHorizontalDragCancel: () {
          _isDragging = false;
        },
        child: Stack(
          children: [
            // ── 主内容：垂直 PageView 切换图片 ──
            PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: total,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                final image = images[index];
                return _GalleryImageItem(
                  assetPath: image.assetPath,
                  index: index,
                  total: total,
                  title: image.title,
                  subtitle: image.subtitle,
                );
              },
            ),

            // ── 顶部遮罩 + 返回提示 + 标题 ──
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _GalleryTopBar(),
            ),

            // ── 左侧图片进度条 ──
            if (total > 1)
              Positioned(
                left: 8,
                top: MediaQuery.of(context).size.height * 0.42,
                child: _GalleryProgressBar(
                  total: total,
                  current: _currentPage,
                ),
              ),

            // ── 右侧「右滑返回」提示 ──
            const Positioned(
              right: 4,
              top: 0,
              bottom: 0,
              child: _SwipeBackHint(),
            ),

            // ── 底部「上下滑动」提示 ──
            if (total > 1)
              const Positioned(
                left: 0,
                right: 0,
                bottom: 6,
                child: _ScrollHint(),
              ),
          ],
        ),
      ),
    );
  }
}

// ── 单张图片 + 底部说明 ──

class _GalleryImageItem extends StatelessWidget {
  final String assetPath;
  final int index;
  final int total;
  final String title;
  final String subtitle;

  const _GalleryImageItem({
    required this.assetPath,
    required this.index,
    required this.total,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF11100E),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 图片
          Image.asset(
            assetPath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // 图片加载失败时的占位
              return Container(
                color: const Color(0xFF2A2520),
                child: const Center(
                  child: Icon(Icons.broken_image_outlined,
                      color: Colors.white24, size: 48),
                ),
              );
            },
          ),

          // 上下渐变遮罩（增强文字可读性）
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x8C000000), // 顶部深遮罩
                  Color(0x00000000),
                  Color(0x00000000),
                  Color(0xB8000000), // 底部深遮罩
                ],
                stops: [0, 0.26, 0.66, 1],
              ),
            ),
          ),

          // 底部图片说明
          Positioned(
            left: 16,
            right: 16,
            bottom: 22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 序号标签
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${index + 1} / $total',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                // 标题
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.08,
                    letterSpacing: 1,
                    shadows: [
                      Shadow(
                          blurRadius: 12,
                          offset: Offset(0, 2),
                          color: Color(0x59000000)),
                    ],
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xD1FFFFFF),
                      fontSize: 10,
                      height: 1.55,
                      shadows: [
                        Shadow(
                            blurRadius: 6,
                            offset: Offset(0, 1),
                            color: Color(0x44000000)),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── 顶部栏 ──

class _GalleryTopBar extends StatelessWidget {
  const _GalleryTopBar();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.fromLTRB(16, topPadding + 6, 16, 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xB8000000), // 72% 黑
            Color(0x00000000),
          ],
        ),
      ),
      child: Row(
        children: [
          // 返回按钮
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.white, size: 12),
                  SizedBox(width: 4),
                  Text(
                    '右滑返回列表',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── 左侧图片进度条 ──

class _GalleryProgressBar extends StatelessWidget {
  final int total;
  final int current;

  const _GalleryProgressBar({required this.total, required this.current});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final active = i == current;
        return Container(
          width: 3,
          height: active ? 24 : 13,
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: active
                ? Colors.white
                : Colors.white.withValues(alpha: 0.3),
          ),
        );
      }),
    );
  }
}

// ── 右侧「右滑返回」提示 ──

class _SwipeBackHint extends StatelessWidget {
  const _SwipeBackHint();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(999),
        ),
        child: const Text(
          '右滑\n返回',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xCCFFFFFF),
            fontSize: 8,
            fontWeight: FontWeight.w700,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

// ── 底部「上下滑动」提示 ──

class _ScrollHint extends StatelessWidget {
  const _ScrollHint();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(999),
        ),
        child: const Text(
          '↑ 上下滑动查看更多图片 ↓',
          style: TextStyle(
            color: Color(0xB8FFFFFF),
            fontSize: 8,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
