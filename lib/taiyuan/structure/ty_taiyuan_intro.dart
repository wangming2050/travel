// ============================================
// 文件: lib/ty_taiyuan/ty_taiyuan_intro.dart
// 用途: 太原城市 - 介绍 Tab — 浅色主题 v2
// 作者: testerwm
// 创建: 2026-06-09
// ============================================

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../l10n/ty_app_localizations.dart';
import '../shared/ty_colors.dart';
import '../ty_city_page.dart';
import '../shared/ty_widgets.dart';

class TaiyuanIntroTab extends StatelessWidget {
  const TaiyuanIntroTab();

  @override
  Widget build(BuildContext c) {
    final l10n = AppLocalizations.of(c);
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 20),
      physics: const BouncingScrollPhysics(),
      children: [
        // 城市视频
        const _VideoCard(),
        const SizedBox(height: 12),
        // 数据统计
        StatsRow(
          s1: (l10n['statPopulationValue'], l10n['statPopulation']),
          s2: (l10n['statHistoryValue'], l10n['statHistory']),
          s3: (l10n['statScenicValue'], l10n['statScenic']),
        ),
        const SizedBox(height: 14),
        // 介绍文本
        TextBlock(l10n['introText']),
        const SizedBox(height: 14),
        // 城市标签
        SectionTitle(l10n['sectionTags']),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            AccentPill(l10n['tagCulture']),
            DimPill(l10n['tagDragon']),
            DimPill(l10n['tagJinyang']),
            DimPill(l10n['tagFenRiver']),
            DimPill(l10n['tagNoodle']),
            DimPill(l10n['tagTwinPagoda']),
          ],
        ),
        const SizedBox(height: 14),
        // 气候信息
        InfoGrid(
          t1: InfoTile(label: l10n['infoSeason'], value: l10n['infoSeasonValue']),
          t2: InfoTile(label: l10n['infoTemp'], value: l10n['infoTempValue']),
        ),
        const SizedBox(height: 14),
        // 扩展内容
        SectionTitle(l10n['introHistory']),
        TextBlock(l10n['introHistoryText']),
        const SizedBox(height: 14),
        SectionTitle(l10n['introClimate']),
        TextBlock(l10n['introClimateText']),
        const SizedBox(height: 14),
        SectionTitle(l10n['introFood']),
        TextBlock(l10n['introFoodText']),
        const SizedBox(height: 14),
        SectionTitle(l10n['introTransport']),
        TextBlock(l10n['introTransportText']),
      ],
    );
  }
}

// ── 视频卡片（设计稿风格：渐变背景 + 底部覆盖层） ──

class _VideoCard extends StatefulWidget {
  const _VideoCard();

  @override
  State<_VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<_VideoCard>
    with AutomaticKeepAliveClientMixin {
  late final VideoPlayerController _ctrl;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _ctrl = VideoPlayerController.asset(
      'assets/ty_taiyuan/video/ty_taiyuan.mp4',
    )
      ..initialize().then((_) {
        if (mounted) {
          _ctrl.setLooping(true);
          _ctrl.play();
          _ctrl.addListener(() {
            if (mounted) setState(() {});
          });
          setState(() {});
        }
      });
    CityPage.activeTab.addListener(_onTabChange);
  }

  void _onTabChange() {
    if (!_ctrl.value.isInitialized) return;
    if (CityPage.activeTab.value != 0) {
      _ctrl.pause();
    }
  }

  void _togglePlay() {
    if (_ctrl.value.isPlaying) {
      _ctrl.pause();
    } else {
      _ctrl.play();
    }
  }

  void _openFullScreen() {
    final wasPlaying = _ctrl.value.isPlaying;
    if (wasPlaying) _ctrl.pause();
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: true,
        fullscreenDialog: true,
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) =>
            _FullScreenVideo(ctrl: _ctrl, wasPlaying: wasPlaying),
        transitionsBuilder: (_, a, __, child) =>
            FadeTransition(opacity: a, child: child),
      ),
    ).then((_) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    });
  }

  @override
  void dispose() {
    CityPage.activeTab.removeListener(_onTabChange);
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext c) {
    super.build(c);
    final ready = _ctrl.value.isInitialized;
    final playing = _ctrl.value.isPlaying;

    final screenW = MediaQuery.of(context).size.width;
    final videoH = (screenW - 36) * 0.54; // 16:9 比例自适应

    return GestureDetector(
      onTap: _togglePlay,
      child: Container(
        height: videoH.clamp(160.0, 240.0).toDouble(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowMid,
              blurRadius: 20,
              offset: Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(fit: StackFit.expand, children: [
          // 背景：视频或加载
          if (ready)
            VideoPlayer(_ctrl)
          else
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFd4a574), Color(0xFFa8956a)],
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            ),
          // 径向高光
          if (ready)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-0.4, -0.6),
                    radius: 1.5,
                    colors: [
                      Colors.white.withValues(alpha: .12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          // 底部覆盖层
          if (ready)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 28, 12, 10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0x59000000)],
                  ),
                ),
                child: Row(children: [
                  GestureDetector(
                    onTap: _togglePlay,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: .3),
                      ),
                      child: Center(
                        child: Icon(
                          playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      '锦绣太原',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _openFullScreen,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: .2),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.fullscreen_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          // 暂停时中心播放按钮
          if (ready && !playing)
            const Center(
              child: Icon(
                Icons.play_circle_fill_rounded,
                color: Colors.white,
                size: 48,
              ),
            ),
        ]),
      ),
    );
  }
}

// ── 全屏视频 ──

class _FullScreenVideo extends StatefulWidget {
  final VideoPlayerController ctrl;
  final bool wasPlaying;
  const _FullScreenVideo({required this.ctrl, required this.wasPlaying});

  @override
  State<_FullScreenVideo> createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<_FullScreenVideo> {
  bool _showControls = true;
  bool _isLandscape = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    widget.ctrl.play();
    _startHideTimer();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  Timer? _hideTimer;
  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showControls = false);
    });
  }

  void _onVideoTap() {
    if (widget.ctrl.value.isPlaying) {
      widget.ctrl.pause();
    } else {
      widget.ctrl.play();
    }
    setState(() => _showControls = true);
    _startHideTimer();
  }

  void _toggleOrientation() {
    setState(() => _isLandscape = !_isLandscape);
    if (_isLandscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  Widget build(BuildContext c) {
    widget.ctrl.addListener(() {
      if (mounted) setState(() {});
    });
    final playing = widget.ctrl.value.isPlaying;
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _onVideoTap,
        child: Stack(fit: StackFit.expand, children: [
          Center(
            child: AspectRatio(
              aspectRatio: widget.ctrl.value.aspectRatio,
              child: VideoPlayer(widget.ctrl),
            ),
          ),
          if (_showControls) ...[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  8,
                  MediaQuery.of(c).padding.top + 8,
                  8,
                  8,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x99000000), Colors.transparent],
                  ),
                ),
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      widget.ctrl.pause();
                      Navigator.of(c).pop();
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: .2),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _toggleOrientation,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: .2),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.screen_rotation_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  16,
                  8,
                  16,
                  MediaQuery.of(c).padding.bottom + 16,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0x99000000), Colors.transparent],
                  ),
                ),
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      if (playing) {
                        widget.ctrl.pause();
                      } else {
                        widget.ctrl.play();
                      }
                      _startHideTimer();
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: .2),
                      ),
                      child: Center(
                        child: Icon(
                          playing
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: VideoProgressIndicator(
                      widget.ctrl,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: AppColors.red,
                        bufferedColor: Color(0x4DFFFFFF),
                        backgroundColor: Color(0x26FFFFFF),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            if (!playing)
              Center(
                child: GestureDetector(
                  onTap: () {
                    widget.ctrl.play();
                    _startHideTimer();
                  },
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: .25),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ]),
      ),
    );
  }
}
