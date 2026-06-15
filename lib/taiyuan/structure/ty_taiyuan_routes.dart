// ============================================
// 文件: lib/taiyuan/structure/ty_taiyuan_routes.dart
// 用途: 太原城市 - 路线 Tab — redesign v3
// 作者: testerwm + Claude
// 创建: 2026-06-09 / 更新: 2026-06-13
// 说明: 步骤卡片增加缩略图，展开显示标签组 + 说明文字
//       交互增强：点击展开详情，箭头旋转 90°
// ============================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/ty_app_localizations.dart';
import '../shared/ty_colors.dart';

// ── 路线步骤数据模型 ──

class _RouteStepData {
  final String name;
  final String desc;
  final String time;
  final String image;
  final List<String> tags;
  final String detailText;

  const _RouteStepData({
    required this.name,
    required this.desc,
    required this.time,
    required this.image,
    required this.tags,
    required this.detailText,
  });
}

class _RouteData {
  final String title;
  final String sub;
  final String pill;
  final String day;
  final String stops;
  final String budget;
  final List<_RouteStepData> steps;

  const _RouteData({
    required this.title,
    required this.sub,
    required this.pill,
    required this.day,
    required this.stops,
    required this.budget,
    required this.steps,
  });
}

// ── 路线数据构建器（从 l10n 获取翻译文案） ──

List<_RouteData> _buildRoutes(AppLocalizations l10n) {
  String g(String k) => l10n[k];
  String gn(String k) => l10n[k].isEmpty ? '' : l10n[k];

  return [
    _RouteData(
      title: g('rt_lc_title'), sub: g('rt_lc_sub'), pill: g('rt_lc_pill'),
      day: g('rt_lc_day'), stops: g('rt_lc_stops'), budget: g('rt_lc_budget'),
      steps: [
        _RouteStepData(name: g('rt_lc_s0n'), desc: g('rt_lc_s0d'), time: '09:00', image: 'assets/ty_taiyuan/video/images/taiyuan/bwy.jpg',
          tags: [g('rt_lc_s0t0'), g('rt_lc_s0t1'), g('rt_lc_s0t2'), g('rt_lc_s0t3')], detailText: g('rt_lc_s0dt')),
        _RouteStepData(name: g('rt_lc_s1n'), desc: g('rt_lc_s1d'), time: '13:00', image: 'assets/ty_taiyuan/video/images/taiyuan/st.jpg',
          tags: [g('rt_lc_s1t0'), g('rt_lc_s1t1'), g('rt_lc_s1t2'), g('rt_lc_s1t3')], detailText: g('rt_lc_s1dt')),
        _RouteStepData(name: g('rt_lc_s2n'), desc: g('rt_lc_s2d'), time: '17:00', image: 'assets/ty_taiyuan/video/images/taiyuan/fh.jpg',
          tags: [g('rt_lc_s2t0'), g('rt_lc_s2t1'), g('rt_lc_s2t2'), g('rt_lc_s2t3')], detailText: g('rt_lc_s2dt')),
      ],
    ),
    _RouteData(
      title: g('rt_gj_title'), sub: g('rt_gj_sub'), pill: gn('rt_gj_pill'),
      day: g('rt_gj_day'), stops: g('rt_gj_stops'), budget: g('rt_gj_budget'),
      steps: [
        _RouteStepData(name: g('rt_gj_s0n'), desc: g('rt_gj_s0d'), time: '08:30', image: 'assets/ty_taiyuan/video/images/taiyuan/jinci.jpg',
          tags: [g('rt_gj_s0t0'), g('rt_gj_s0t1'), g('rt_gj_s0t2'), g('rt_gj_s0t3')], detailText: g('rt_gj_s0dt')),
        _RouteStepData(name: g('rt_gj_s1n'), desc: g('rt_gj_s1d'), time: '13:30', image: 'assets/ty_taiyuan/video/images/taiyuan/tls.jpg',
          tags: [g('rt_gj_s1t0'), g('rt_gj_s1t1'), g('rt_gj_s1t2'), g('rt_gj_s1t3')], detailText: g('rt_gj_s1dt')),
        _RouteStepData(name: g('rt_gj_s2n'), desc: g('rt_gj_s2d'), time: '16:00', image: 'assets/ty_taiyuan/video/images/taiyuan/ms.jpg',
          tags: [g('rt_gj_s2t0'), g('rt_gj_s2t1'), g('rt_gj_s2t2'), g('rt_gj_s2t3')], detailText: g('rt_gj_s2dt')),
      ],
    ),
    _RouteData(
      title: g('rt_wd_title'), sub: g('rt_wd_sub'), pill: g('rt_wd_pill'),
      day: g('rt_wd_day'), stops: g('rt_wd_stops'), budget: g('rt_wd_budget'),
      steps: [
        _RouteStepData(name: g('rt_wd_s0n'), desc: g('rt_wd_s0d'), time: '08:00', image: 'assets/ty_taiyuan/video/images/taiyuan/tn.jpg',
          tags: [g('rt_wd_s0t0'), g('rt_wd_s0t1'), g('rt_wd_s0t2'), g('rt_wd_s0t3')], detailText: g('rt_wd_s0dt')),
        _RouteStepData(name: g('rt_wd_s1n'), desc: g('rt_wd_s1d'), time: '12:00', image: 'assets/ty_taiyuan/video/images/taiyuan/noodle.jpg',
          tags: [g('rt_wd_s1t0'), g('rt_wd_s1t1'), g('rt_wd_s1t2'), g('rt_wd_s1t3')], detailText: g('rt_wd_s1dt')),
        _RouteStepData(name: g('rt_wd_s2n'), desc: g('rt_wd_s2d'), time: '14:30', image: 'assets/ty_taiyuan/video/images/taiyuan/sm1.jpg',
          tags: [g('rt_wd_s2t0'), g('rt_wd_s2t1'), g('rt_wd_s2t2'), g('rt_wd_s2t3')], detailText: g('rt_wd_s2dt')),
      ],
    ),
    _RouteData(
      title: g('rt_qz_title'), sub: g('rt_qz_sub'), pill: gn('rt_qz_pill'),
      day: g('rt_qz_day'), stops: g('rt_qz_stops'), budget: g('rt_qz_budget'),
      steps: [
        _RouteStepData(name: g('rt_qz_s0n'), desc: g('rt_qz_s0d'), time: '09:30', image: 'assets/ty_taiyuan/video/images/taiyuan/bwy.jpg',
          tags: [g('rt_qz_s0t0'), g('rt_qz_s0t1'), g('rt_qz_s0t2'), g('rt_qz_s0t3')], detailText: g('rt_qz_s0dt')),
        _RouteStepData(name: g('rt_qz_s1n'), desc: g('rt_qz_s1d'), time: '14:00', image: 'assets/ty_taiyuan/video/images/taiyuan/zwy.jpg',
          tags: [g('rt_qz_s1t0'), g('rt_qz_s1t1'), g('rt_qz_s1t2'), g('rt_qz_s1t3')], detailText: g('rt_qz_s1dt')),
        _RouteStepData(name: g('rt_qz_s2n'), desc: g('rt_qz_s2d'), time: '16:30', image: 'assets/ty_taiyuan/video/images/taiyuan/fh.jpg',
          tags: [g('rt_qz_s2t0'), g('rt_qz_s2t1'), g('rt_qz_s2t2'), g('rt_qz_s2t3')], detailText: g('rt_qz_s2dt')),
      ],
    ),
    _RouteData(
      title: g('rt_ss_title'), sub: g('rt_ss_sub'), pill: gn('rt_ss_pill'),
      day: g('rt_ss_day'), stops: g('rt_ss_stops'), budget: g('rt_ss_budget'),
      steps: [
        _RouteStepData(name: g('rt_ss_s0n'), desc: g('rt_ss_s0d'), time: '08:30', image: 'assets/ty_taiyuan/video/images/taiyuan/tslqs.jpg',
          tags: [g('rt_ss_s0t0'), g('rt_ss_s0t1'), g('rt_ss_s0t2'), g('rt_ss_s0t3')], detailText: g('rt_ss_s0dt')),
        _RouteStepData(name: g('rt_ss_s1n'), desc: g('rt_ss_s1d'), time: '14:00', image: 'assets/ty_taiyuan/video/images/taiyuan/tls.jpg',
          tags: [g('rt_ss_s1t0'), g('rt_ss_s1t1'), g('rt_ss_s1t2'), g('rt_ss_s1t3')], detailText: g('rt_ss_s1dt')),
      ],
    ),
  ];
}

// ── 路线 Tab ──

class TaiyuanRoutesTab extends StatefulWidget {
  const TaiyuanRoutesTab({super.key});

  @override
  State<TaiyuanRoutesTab> createState() => _TaiyuanRoutesTabState();
}

class _TaiyuanRoutesTabState extends State<TaiyuanRoutesTab> {
  int _sel = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final routes = _buildRoutes(l10n);
    final route = routes[_sel];

    return Column(
      children: [
        const SizedBox(height: 12),
        // ── Chip 切换器 ──
        SizedBox(
          height: 34,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 18),
            itemCount: routes.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, i) {
              final active = i == _sel;
              return GestureDetector(
                onTap: () => setState(() => _sel = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    gradient: active
                        ? const LinearGradient(
                            colors: [AppColors.red2, AppColors.red],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                        : null,
                    color: active
                        ? null
                        : Colors.white.withValues(alpha: 0.72),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: active ? Colors.transparent : AppColors.goldBorder,
                    ),
                    boxShadow: active
                        ? const [
                            BoxShadow(
                              color: Color(0x38B84C2E),
                              blurRadius: 14,
                              offset: Offset(0, 4),
                            ),
                          ]
                        : const [
                            BoxShadow(
                              color: Color(0x0A1E1810),
                              blurRadius: 6,
                              offset: Offset(0, 1),
                            ),
                          ],
                  ),
                  child: Text(
                    routes[i].title,
                    style: TextStyle(
                      color: active ? Colors.white : AppColors.ink2,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // ── 路线内容 ──
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: ListView(
              key: ValueKey(_sel),
              padding: const EdgeInsets.only(bottom: 20),
              physics: const BouncingScrollPhysics(),
              children: [
                _RouteHeader(
                  title: route.title,
                  sub: route.sub,
                  pill: route.pill,
                ),
                const SizedBox(height: 8),
                for (int i = 0; i < route.steps.length; i++)
                  _RouteStepWidget(
                    stepNum: i + 1,
                    data: route.steps[i],
                    isLast: i == route.steps.length - 1,
                  ),
                const SizedBox(height: 6),
                _CopyRouteButton(route: route),
                const SizedBox(height: 12),
                _RouteStats(
                  day: route.day,
                  stops: route.stops,
                  budget: route.budget,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── 路线头部 ──

class _RouteHeader extends StatelessWidget {
  final String title;
  final String sub;
  final String pill;
  const _RouteHeader({required this.title, required this.sub, required this.pill});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Noto Serif SC',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  sub,
                  style: const TextStyle(
                    color: AppColors.ink3,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          if (pill.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.goldBg,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColors.goldBorder),
              ),
              child: Text(
                pill,
                style: const TextStyle(
                  color: AppColors.gold,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── 单个路线步骤（可展开/收起） ──

class _RouteStepWidget extends StatefulWidget {
  final int stepNum;
  final _RouteStepData data;
  final bool isLast;

  const _RouteStepWidget({
    required this.stepNum,
    required this.data,
    required this.isLast,
  });

  @override
  State<_RouteStepWidget> createState() => _RouteStepWidgetState();
}

class _RouteStepWidgetState extends State<_RouteStepWidget>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _arrowController;
  late Animation<double> _arrowTurns;

  @override
  void initState() {
    super.initState();
    _arrowController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _arrowTurns = Tween(begin: 0.0, end: 0.25).animate(
      CurvedAnimation(parent: _arrowController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _arrowController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _arrowController.forward();
      } else {
        _arrowController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.isLast ? 0 : 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 时间线脊柱 ──
          SizedBox(
            width: 46,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.red2, AppColors.red],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x52B84C2E),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${widget.stepNum}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                if (!widget.isLast)
                  Container(
                    width: 3,
                    height: _expanded ? 70 : 54,
                    margin: const EdgeInsets.symmetric(vertical: 7),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      gradient: LinearGradient(
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
                  ),
              ],
            ),
          ),
          // ── 步骤卡片 ──
          Expanded(
            child: GestureDetector(
              onTap: _toggle,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.only(bottom: widget.isLast ? 0 : 12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.88),
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: AppColors.border2),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x141E1810),
                      blurRadius: 12,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    // ── 摘要行：文字 + 图片 + 箭头 ──
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 15, 12, 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 左侧文字
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.data.name,
                                  style: const TextStyle(
                                    color: AppColors.ink,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800,
                                    height: 1.15,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  widget.data.desc,
                                  style: const TextStyle(
                                    color: AppColors.ink3,
                                    fontSize: 15,
                                    height: 1.45,
                                  ),
                                ),
                                const SizedBox(height: 13),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time_rounded,
                                        size: 16, color: AppColors.red),
                                    const SizedBox(width: 6),
                                    Text(
                                      widget.data.time,
                                      style: const TextStyle(
                                        color: AppColors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          // 右侧缩略图
                          ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: SizedBox(
                              width: 142,
                              height: 95,
                              child: Image.asset(
                                widget.data.image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  color: const Color(0xFFD6CAB8),
                                  child: const Center(
                                    child: Icon(Icons.image_outlined,
                                        color: Colors.white38, size: 32),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // 展开箭头
                          RotationTransition(
                            turns: _arrowTurns,
                            child: const Icon(
                              Icons.chevron_right_rounded,
                              size: 22,
                              color: AppColors.ink3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ── 展开详情：标签 + 说明文字 ──
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: _StepDetail(
                        tags: widget.data.tags,
                        detailText: widget.data.detailText,
                      ),
                      crossFadeState: _expanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 250),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── 展开详情区域 ──

class _StepDetail extends StatelessWidget {
  final List<String> tags;
  final String detailText;

  const _StepDetail({required this.tags, required this.detailText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border2)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0x8CF8F3EC),
            Color(0x59FFFFFF),
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标签行
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: tags
                .map((tag) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.goldBg,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: const Color(0x249B7A3A)),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          // 详细说明
          Text(
            detailText,
            style: const TextStyle(
              color: AppColors.ink3,
              fontSize: 13,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

// ── 复制路线按钮 ──

class _CopyRouteButton extends StatelessWidget {
  final _RouteData route;
  const _CopyRouteButton({required this.route});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        onTap: () {
          final lines = ['${route.title} — ${route.sub}', ''];
          for (int i = 0; i < route.steps.length; i++) {
            final s = route.steps[i];
            lines.add('${i + 1}. ${s.time}  ${s.name}');
            lines.add('   ${s.desc}');
            lines.add('');
          }
          Clipboard.setData(ClipboardData(text: lines.join('\n')));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n['route_copied'],
                  style: const TextStyle(fontSize: 13)),
              backgroundColor: AppColors.ink2,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        },
        borderRadius: BorderRadius.circular(17),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.red2, AppColors.red],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.all(Radius.circular(17)),
            boxShadow: [
              BoxShadow(
                color: Color(0x47B84C2E),
                blurRadius: 18,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.content_copy_rounded,
                  color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                l10n['route_copy_btn'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── 底部统计卡片 ──

class _RouteStats extends StatelessWidget {
  final String day;
  final String stops;
  final String budget;

  const _RouteStats({
    required this.day,
    required this.stops,
    required this.budget,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(child: _StatBox(num: day, label: l10n['stat_days'])),
          const SizedBox(width: 10),
          Expanded(child: _StatBox(num: stops, label: l10n['stat_stops'])),
          const SizedBox(width: 10),
          Expanded(child: _StatBox(num: budget, label: l10n['stat_budget_person'])),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String num;
  final String label;

  const _StatBox({required this.num, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 73),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x141E1810),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            num,
            style: const TextStyle(
              color: AppColors.red,
              fontSize: 29,
              fontWeight: FontWeight.w700,
              fontFamily: 'Noto Serif SC',
              height: 1.0,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.ink3,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
