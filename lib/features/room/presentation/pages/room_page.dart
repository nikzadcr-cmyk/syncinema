import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/theme/colors.dart';
import '../../../../core/network/websocket_service.dart';
import '../providers/room_provider.dart';
import '../../../chat/presentation/widgets/chat_panel.dart';
import '../widgets/users_grid.dart';
import '../widgets/room_actions.dart';
import '../../../home/presentation/widgets/glow_orb.dart';

class RoomPage extends ConsumerStatefulWidget {
  final String roomId;
  const RoomPage({super.key, required this.roomId});

  @override
  ConsumerState<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends ConsumerState<RoomPage> {
  bool _showChat = false;

  @override
  Widget build(BuildContext context) {
    final roomState = ref.watch(roomProvider);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          Positioned.fill(child: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF0A0A12), Color(0xFF17172A)], begin: Alignment.topCenter, end: Alignment.bottomCenter)))),
          Positioned(top: -50, left: -50, child: GlowOrb(color: AppColors.primary.withOpacity(0.18), size: 260)),

          SafeArea(
            child: isLandscape ? _buildLandscape(context, roomState) : _buildPortrait(context, roomState),
          ),

          // Chat overlay for landscape
          if (isLandscape && _showChat)
            Positioned(
              right: 0, top: 0, bottom: 0,
              width: 380,
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(24)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    decoration: BoxDecoration(color: AppColors.surfaceDark.withOpacity(0.85), border: Border(left: BorderSide(color: Colors.white.withOpacity(0.08)))),
                    child: ChatPanel(onClose: () => setState(() => _showChat = false)),
                  ),
                ),
              ).animate().slideX(begin: 1, end: 0, duration: 350.ms, curve: Curves.easeOutCubic),
            ),
        ],
      ),
      bottomSheet: isLandscape ? null : (roomState.status == RoomStatus.connected ? _buildBottomBar(context) : null),
    );
  }

  Widget _buildPortrait(BuildContext context, RoomStateData roomState) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          pinned: true,
          expandedHeight: 80,
          leading: _glassButton(Icons.arrow_back_rounded, () => context.go('/')),
          actions: [
            _glassButton(Icons.chat_bubble_rounded, () => _showChatSheet(context)),
            const Gap(8),
            _glassButton(Icons.more_vert_rounded, () => _showOptions(context)),
            const Gap(12),
          ],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(roomState.room?.name ?? 'Room ${widget.roomId}', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                Row(
                  children: [
                    Container(width: 8, height: 8, decoration: BoxDecoration(color: roomState.wsState == WsConnectionState.connected ? AppColors.success : AppColors.error, shape: BoxShape.circle)),
                    const Gap(6),
                    Text('${roomState.users.length} نفر • پینگ ${roomState.ping}ms', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textSecondaryDark)),
                  ],
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Room code card
                _roomCodeCard(context),
                const Gap(20),

                // Media selection placeholder
                _mediaSelectionCard(context),

                const Gap(20),

                Text('افراد حاضر (${roomState.users.length})', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const Gap(12),
                UsersGrid(users: roomState.users, currentUserId: roomState.currentUserId, isHost: roomState.isHost, onTransferHost: (id) => ref.read(roomProvider.notifier).transferHost(id)),

                const Gap(20),

                // Settings
                if (roomState.isHost) _hostSettingsCard(context, roomState),

                const Gap(100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscape(BuildContext context, RoomStateData roomState) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    _glassButton(Icons.arrow_back_rounded, () => context.go('/')),
                    const Gap(12),
                    Expanded(child: Text(roomState.room?.name ?? widget.roomId, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800))),
                    _glassButton(Icons.chat_bubble_rounded, () => setState(() => _showChat = !_showChat)),
                    const Gap(8),
                    _glassButton(Icons.more_vert_rounded, () => _showOptions(context)),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _roomCodeCard(context)),
                      const Gap(16),
                      Expanded(child: _mediaSelectionCard(context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _roomCodeCard(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.08))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('کد اتاق', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.textSecondaryDark)),
                  Row(
                    children: [
                      _miniGlassBtn(Icons.copy_rounded, onTap: () {}),
                      const Gap(8),
                      _miniGlassBtn(Icons.share_rounded, onTap: () => SharePlus.instance.share(ShareParams(text: 'Join my Syncinema room: ${widget.roomId} https://syncinema.app/join?roomId=${widget.roomId}'))),
                    ],
                  ),
                ],
              ),
              const Gap(16),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(color: AppColors.surfaceDark2, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.primary.withOpacity(0.2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.roomId.split('').map((c) => Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: Text(c, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900, letterSpacing: 2)))).toList(),
                ),
              ),
              const Gap(16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(onPressed: () => _showQr(context), icon: const Icon(Icons.qr_code_rounded, size: 20), label: const Text('QR Code'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.surfaceDark3, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
                  ),
                  const Gap(10),
                  Expanded(
                    child: ElevatedButton.icon(onPressed: () => context.push('/room/${widget.roomId}/player'), icon: const Icon(Icons.play_arrow_rounded), label: const Text('ورود به پلیر'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mediaSelectionCard(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.primary.withOpacity(0.12), AppColors.secondary.withOpacity(0.08)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.08))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.video_library_rounded, color: AppColors.primaryLight, size: 20)),
                  const Gap(12),
                  Text('انتخاب فایل', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                ],
              ),
              const Gap(16),
              Text('هر کاربر فایل خودش را از حافظه انتخاب می‌کند. نام فایل باید یکسان باشد یا دستی همگام می‌کنید.', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondaryDark, height: 1.5)),
              const Gap(16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => context.push('/room/${widget.roomId}/player'),
                  icon: const Icon(Icons.folder_open_rounded),
                  label: const Text('انتخاب ویدیو / موسیقی'),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: BorderSide(color: Colors.white.withOpacity(0.15)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(vertical: 14)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _hostSettingsCard(BuildContext context, RoomStateData state) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.06))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('تنظیمات میزبان', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('کنترل همگانی'),
                  Switch(value: state.room?.allowAllControl ?? true, onChanged: (v) => ref.read(roomProvider.notifier).toggleAllowAllControl(v)),
                ],
              ),
              Text('اگر فعال باشد همه اعضا می‌توانند پخش را کنترل کنند', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textSecondaryDark)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassButton(IconData icon, VoidCallback onTap) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: InkWell(
          onTap: onTap,
          child: Container(width: 42, height: 42, decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white.withOpacity(0.08))), child: Icon(icon, size: 20)),
        ),
      ),
    );
  }

  Widget _miniGlassBtn(IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(width: 34, height: 34, decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(8)), child: Icon(icon, size: 16)),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(color: AppColors.surfaceDark.withOpacity(0.9), border: Border(top: BorderSide(color: Colors.white.withOpacity(0.06)))),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(child: ElevatedButton.icon(onPressed: () => context.push('/room/${widget.roomId}/player'), icon: const Icon(Icons.play_circle_fill_rounded), label: const Text('شروع تماشا'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))))),
                const Gap(12),
                _glassButton(Icons.chat_bubble_rounded, () => _showChatSheet(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showChatSheet(BuildContext context) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (_) => DraggableScrollableSheet(initialChildSize: 0.75, maxChildSize: 0.92, minChildSize: 0.5, builder: (_, ctrl) => ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(28)), child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), child: Container(color: AppColors.surfaceDark.withOpacity(0.95), child: ChatPanel(scrollController: ctrl))))));
  }

  void _showQr(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: AppColors.surfaceDark2, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white.withOpacity(0.1))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('QR دعوت', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                  const Gap(20),
                  Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: QrImageView(data: 'https://syncinema.app/join?roomId=${widget.roomId}', size: 200, backgroundColor: Colors.white)),
                  const Gap(16),
                  Text(widget.roomId, style: Theme.of(context).textTheme.headlineSmall?.copyWith(letterSpacing: 4, fontWeight: FontWeight.w900)),
                  const Gap(20),
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('بستن'))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: AppColors.surfaceDark, borderRadius: const BorderRadius.vertical(top: Radius.circular(24))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(leading: const Icon(Icons.logout_rounded, color: AppColors.error), title: const Text('خروج از اتاق'), onTap: () async { Navigator.pop(context); await ref.read(roomProvider.notifier).leaveRoom(); if (context.mounted) context.go('/'); }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
