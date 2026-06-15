// ============================================
// 文件: lib/shared/ty_ai_assistant_sheet.dart
// 用途: AI 旅行助手底部弹窗 — 对接 DeepSeek API 流式对话
// 说明:
//   - 点击城市页 emoji 图标唤起
//   - 支持流式输出（打字机效果）
//   - 通过代理服务器调用 DeepSeek API
//   - 支持中/英/韩三语切换
// ============================================

import 'package:flutter/material.dart';

import '../l10n/ty_app_localizations.dart';
import 'ty_ai_service.dart';
import 'ty_colors.dart';

/// 显示 AI 助手弹窗
Future<void> showTyAiAssistantSheet(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  final lang = l10n.locale.languageCode;
  final service = TyAiService(lang: lang);

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: const Color(0x661E1810),
    builder: (context) => _TyAiAssistantSheet(
      service: service,
      greeting: l10n['aiGreeting'],
      l10n: l10n,
    ),
  );
}

// ============================================================
// 主 Widget
// ============================================================

class _TyAiAssistantSheet extends StatefulWidget {
  final TyAiService service;
  final String greeting;
  final AppLocalizations l10n;

  const _TyAiAssistantSheet({
    required this.service,
    required this.greeting,
    required this.l10n,
  });

  @override
  State<_TyAiAssistantSheet> createState() => _TyAiAssistantSheetState();
}

class _TyAiAssistantSheetState extends State<_TyAiAssistantSheet> {
  late final _messages = <TyAiMessage>[
    TyAiMessage(role: 'assistant', content: widget.greeting),
  ];
  final _controller = TextEditingController();
  final _scrollCtrl = ScrollController();
  bool _isLoading = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollCtrl.dispose();
    widget.service.dispose();
    super.dispose();
  }

  AppLocalizations get l10n => widget.l10n;

  void _scrollToBottom() {
    if (_scrollCtrl.hasClients) {
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  /// 发送消息
  Future<void> _sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || _isLoading) return;

    _controller.clear();
    _errorText = null;

    setState(() {
      _messages.add(TyAiMessage(role: 'user', content: trimmed));
      _messages.add(const TyAiMessage(role: 'assistant', content: ''));
      _isLoading = true;
    });

    final apiMessages = _messages
        .where((m) => m.role == 'user')
        .map((m) => TyAiMessage(role: 'user', content: m.content))
        .toList();

    try {
      await for (final chunk in widget.service.chatStream(apiMessages)) {
        if (!mounted) return;
        setState(() {
          final idx = _messages.length - 1;
          _messages[idx] = TyAiMessage(
            role: 'assistant',
            content: _messages[idx].content + chunk,
          );
        });
        _scrollToBottom();
      }
    } on TyAiException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorText = e.message;
        if (_messages.last.content.isEmpty) {
          _messages.removeLast();
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorText = l10n['aiUnknownError'];
        if (_messages.last.content.isEmpty) {
          _messages.removeLast();
        }
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
        _scrollToBottom();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        // 弹窗上方空白区域 — 点击关闭
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => Navigator.of(context).pop(),
            child: Container(color: Colors.transparent),
          ),
        ),
        // 弹窗内容
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height * 0.78,
            constraints: const BoxConstraints(maxHeight: 560, minHeight: 360),
            decoration: const BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              border: Border(
                top: BorderSide(color: AppColors.border),
                left: BorderSide(color: AppColors.border),
                right: BorderSide(color: AppColors.border),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowMid,
                  blurRadius: 20,
                  offset: Offset(0, -4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
          children: [
            const SizedBox(height: 12),
            // 拖拽手柄
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            _buildHeader(),
            Expanded(child: _buildMessages()),
            if (_errorText != null) _buildErrorBanner(),
            _buildQuickActions(),
            _buildInputBar(),
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    ),
    ],
    );
  }

  // ── 头部 ──

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border2)),
      ),
      child: Row(
        children: [
          const Text('🤖', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n['aiTitle'],
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n['aiSubtitle'],
                  style: const TextStyle(
                    color: AppColors.ink3,
                    fontSize: 10,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── 消息列表 ──

  Widget _buildMessages() {
    return ListView.builder(
      controller: _scrollCtrl,
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 10),
      physics: const BouncingScrollPhysics(),
      itemCount: _messages.length +
          (_isLoading && _messages.last.content.isEmpty ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _messages.length) {
          return _buildLoadingIndicator();
        }
        final msg = _messages[index];
        final isUser = msg.role == 'user';

        // 加载中跳过空的 AI 占位消息（由 loading dots 代替）
        if (_isLoading && !isUser && msg.content.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.only(
            bottom: index < _messages.length - 1 || _isLoading ? 12 : 0,
          ),
          child: _MessageRow(
            avatar: isUser ? '👤' : '🤖',
            text: msg.content,
            isUser: isUser,
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Avatar(
          text: '🤖',
          color: AppColors.goldBg,
          border: AppColors.goldBorder,
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.goldBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.goldBorder),
          ),
          child: const SizedBox(width: 20, height: 12, child: _LoadingDots()),
        ),
      ],
    );
  }

  // ── 错误提示 ──

  Widget _buildErrorBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.redBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.redBorder),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, size: 14, color: AppColors.red),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                _errorText!,
                style: const TextStyle(
                  color: AppColors.red,
                  fontSize: 10,
                  height: 1.3,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => _errorText = null),
              child: const Icon(Icons.close, size: 14, color: AppColors.red),
            ),
          ],
        ),
      ),
    );
  }

  // ── 快捷操作 ──

  Widget _buildQuickActions() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border2)),
      ),
      child: Wrap(
        spacing: 6,
        runSpacing: 8,
        children: [
          _ActionChip(l10n['aiQuickFood'], () => {}),
          _ActionChip(l10n['aiQuickSpots'], () => {}),
          _ActionChip(l10n['aiQuickHistory'], () => {}),
          _ActionChip(l10n['aiQuickRoute'], () => {}),
        ].map((chip) => chip).toList(),
      ),
    );
  }

  // ── 输入栏 ──

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 14),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: _controller,
                enabled: !_isLoading,
                onSubmitted: (text) => _sendMessage(text),
                decoration: InputDecoration(
                  hintText: _isLoading ? l10n['aiWaiting'] : l10n['aiPlaceholder'],
                  hintStyle: const TextStyle(
                    color: AppColors.ink4,
                    fontSize: 13,
                  ),
                  filled: true,
                  fillColor: _isLoading ? AppColors.border2 : AppColors.bg,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: AppColors.goldBorder),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: AppColors.border2),
                  ),
                ),
                style: const TextStyle(color: AppColors.ink, fontSize: 13),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 40,
            height: 40,
            child: FilledButton(
              onPressed:
                  _isLoading ? null : () => _sendMessage(_controller.text),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.red,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.border,
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
              ),
              child: Icon(
                _isLoading
                    ? Icons.hourglass_top_rounded
                    : Icons.arrow_forward_rounded,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 子组件
// ============================================================

class _MessageRow extends StatelessWidget {
  final String avatar;
  final String text;
  final bool isUser;

  const _MessageRow({
    required this.avatar,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    final avatarColor = isUser ? AppColors.redBg : AppColors.goldBg;
    final avatarBorder = isUser ? AppColors.redBorder : AppColors.goldBorder;
    final bubbleColor = isUser ? AppColors.redBg : AppColors.goldBg;
    final bubbleBorder = isUser ? AppColors.redBorder : AppColors.goldBorder;

    final children = [
      _Avatar(text: avatar, color: avatarColor, border: avatarBorder),
      const SizedBox(width: 8),
      Flexible(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: bubbleBorder),
          ),
          child: Text(
            text.isEmpty ? '…' : text,
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ),
      ),
    ];

    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: isUser ? children.reversed.toList() : children,
    );
  }
}

class _Avatar extends StatelessWidget {
  final String text;
  final Color color;
  final Color border;

  const _Avatar({
    required this.text,
    required this.color,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: border),
      ),
      child: Center(child: Text(text, style: const TextStyle(fontSize: 14))),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _ActionChip(this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        final state =
            context.findAncestorStateOfType<_TyAiAssistantSheetState>();
        state?._sendMessage(text);
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.goldBg,
        foregroundColor: AppColors.gold,
        side: const BorderSide(color: AppColors.goldBorder),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle:
            const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      ),
      child: Text(text),
    );
  }
}

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final dots = ('.' * ((_ctrl.value * 4).floor() + 1));
        return Text(
          dots,
          style: const TextStyle(
            color: AppColors.gold,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        );
      },
    );
  }
}
