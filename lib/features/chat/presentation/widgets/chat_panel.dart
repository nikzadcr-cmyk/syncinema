import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../app/theme/colors.dart';
import '../providers/chat_provider.dart';
import '../../domain/entities/chat_message.dart';
import '../../../room/presentation/providers/room_provider.dart';

class ChatPanel extends ConsumerStatefulWidget {
  final ScrollController? scrollController;
  final VoidCallback? onClose;
  const ChatPanel({super.key, this.scrollController, this.onClose});

  @override
  ConsumerState<ChatPanel> createState() => _ChatPanelState();
}

class _ChatPanelState extends ConsumerState<ChatPanel> {
  final _textCtrl = TextEditingController();
  final _internalScroll = ScrollController();
  final _focus = FocusNode();
  bool _isTyping = false;

  ScrollController get _scroll => widget.scrollController ?? _internalScroll;

  @override
  void initState() {
    super.initState();
    _textCtrl.addListener(() {
      final typing = _textCtrl.text.isNotEmpty;
      if (typing != _isTyping) {
        _isTyping = typing;
        ref.read(chatProvider.notifier).sendTyping(typing);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final roomState = ref.watch(roomProvider);
    final typingUsers = chatState.typingUsers.keys.length;

    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.chat_bubble_rounded, color: AppColors.primaryLight, size: 20)),
              const Gap(12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('چت زنده', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)), Text('${roomState.users.length} آنلاین', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textSecondaryDark))])),
              if (widget.onClose != null)
                IconButton(onPressed: widget.onClose, icon: const Icon(Icons.close_rounded), style: IconButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.06)))
              else
                Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(4))),
            ],
          ),
        ),

        Divider(height: 1, color: Colors.white.withOpacity(0.06)),

        // Messages
        Expanded(
          child: ListView.builder(
            controller: _scroll,
            padding: const EdgeInsets.all(16),
            itemCount: chatState.messages.length + (typingUsers > 0 ? 1 : 0),
            itemBuilder: (context, i) {
              if (i == chatState.messages.length && typingUsers > 0) {
                return _TypingIndicator();
              }
              final msg = chatState.messages[i];
              final isMe = msg.userId == roomState.currentUserId;
              return _MessageBubble(message: msg, isMe: isMe).animate().fadeIn(duration: 300.ms).slideY(begin: 0.2, end: 0);
            },
          ),
        ),

        // Emoji quick bar
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: ['❤️','😂','🔥','👏','😮','🎉','😍','🤩'].map((e) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () => ref.read(chatProvider.notifier).sendReaction(e),
                borderRadius: BorderRadius.circular(20),
                child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(20)), child: Text(e, style: const TextStyle(fontSize: 18))),
              ),
            )).toList(),
          ),
        ),

        // Input
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: MediaQuery.of(context).padding.bottom + 12, top: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textCtrl,
                      focusNode: _focus,
                      style: Theme.of(context).textTheme.bodyMedium,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'پیامی بنویس...',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.06),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onSubmitted: _send,
                    ),
                  ),
                  const Gap(10),
                  Container(
                    decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(14)),
                    child: IconButton(onPressed: () => _send(_textCtrl.text), icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _send(String text) {
    if (text.trim().isEmpty) return;
    ref.read(chatProvider.notifier).sendMessage(text.trim());
    _textCtrl.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scroll.hasClients) _scroll.animateTo(_scroll.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;
  const _MessageBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    if (message.type == MessageType.emoji || message.type == MessageType.reaction) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: isMe ? AppColors.primary.withOpacity(0.15) : Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(20), border: Border.all(color: isMe ? AppColors.primary.withOpacity(0.2) : Colors.white.withOpacity(0.06))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message.userName, style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700, color: isMe ? AppColors.primaryLight : AppColors.textSecondaryDark)),
                const Gap(8),
                Text(message.content, style: const TextStyle(fontSize: 22)),
              ],
            ),
          ),
        ),
      );
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : AppColors.surfaceDark2,
          borderRadius: BorderRadius.only(topLeft: const Radius.circular(18), topRight: const Radius.circular(18), bottomLeft: Radius.circular(isMe ? 18 : 4), bottomRight: Radius.circular(isMe ? 4 : 18)),
          border: isMe ? null : Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe) Text(message.userName, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.primaryLight, fontWeight: FontWeight.w700)),
            if (!isMe) const Gap(4),
            Text(message.content, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white, height: 1.4)),
            const Gap(4),
            Text(_formatTime(message.timestamp), style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white.withOpacity(0.5), fontSize: 10)),
          ],
        ),
      ),
    );
  }

  String _formatTime(int ms) {
    final dt = DateTime.fromMillisecondsSinceEpoch(ms);
    return '${dt.hour.toString().padLeft(2,'0')}:${dt.minute.toString().padLeft(2,'0')}';
  }
}

class _TypingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(16)), child: Row(children: [SizedBox(width: 40, child: Row(children: [0,1,2].map((i) => Container(margin: const EdgeInsets.symmetric(horizontal: 2), width: 6, height: 6, decoration: BoxDecoration(color: AppColors.textSecondaryDark, shape: BoxShape.circle)).animate(onPlay: (c) => c.repeat()).fadeIn(delay: (i*200).ms, duration: 500.ms).then().fadeOut(delay: 200.ms, duration: 500.ms)).toList())), const Gap(8), Text('در حال نوشتن...', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textSecondaryDark))])) ,
        ],
      ),
    );
  }
}
