import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gap/gap.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../../../app/theme/colors.dart';
import '../../providers/player_provider.dart';
import '../../../room/presentation/providers/room_provider.dart';
import '../../../chat/presentation/widgets/chat_panel.dart';
import '../widgets/player_controls.dart';
import '../widgets/subtitle_settings_sheet.dart';
import '../widgets/audio_track_sheet.dart';

class PlayerPage extends ConsumerStatefulWidget {
  final String roomId;
  const PlayerPage({super.key, required this.roomId});

  @override
  ConsumerState<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage> {
  bool _showControls = true;
  bool _showChat = false;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    Future.microtask(() async {
      final room = ref.read(roomProvider);
      await ref.read(playerProvider.notifier).init(roomId: widget.roomId, userId: room.currentUserId ?? 'unknown', isHost: room.isHost);
    });
    _hideControlsAfterDelay();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _hideControlsAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && ref.read(playerProvider).isPlaying) {
        if (mounted) setState(() => _showControls = false);
      }
    });
  }

  void _toggleControls() {
    setState(() => _showControls = !_showControls);
    if (_showControls) _hideControlsAfterDelay();
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp4','mkv','mov','avi','webm','mp3','flac','aac','ogg','wav','m4a'],
        withData: false,
      );
      if (result != null && result.files.single.path != null) {
        final path = result.files.single.path!;
        await ref.read(playerProvider.notifier).loadMedia(path);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فایل انتخاب شد: ${path.split('/').last}')));
        }
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطا: $e')));
    }
  }

  Future<void> _pickSubtitle() async {
    try {
      final result = await FilePicker.pickFiles(type: FileType.custom, allowedExtensions: ['srt','vtt','ass','ssa'], withData: false);
      if (result != null && result.files.single.path != null) {
        await ref.read(playerProvider.notifier).loadExternalSubtitle(result.files.single.path!);
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطا: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(playerProvider);
    final roomState = ref.watch(roomProvider);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onTap: _toggleControls,
            onDoubleTapDown: (details) {
              final width = MediaQuery.of(context).size.width;
              if (details.globalPosition.dx < width / 3) {
                ref.read(playerProvider.notifier).seek(playerState.position - const Duration(seconds: 10));
              } else if (details.globalPosition.dx > width * 2 / 3) {
                ref.read(playerProvider.notifier).seek(playerState.position + const Duration(seconds: 10));
              } else {
                ref.read(playerProvider.notifier).togglePlayPause();
              }
            },
            child: Center(
              child: playerState.videoController != null
                  ? Video(controller: playerState.videoController!, controls: NoVideoControls)
                  : _emptyPlayer(),
            ),
          ),

          if (playerState.mediaFile == null)
            Positioned.fill(child: _emptyPlayer()),

          AnimatedOpacity(
            opacity: _showControls ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            child: IgnorePointer(
              ignoring: !_showControls,
              child: _topBar(context, roomState, isLandscape),
            ),
          ),

          Positioned(
            left: 0, right: isLandscape && _showChat ? 380 : 0, bottom: 0,
            child: AnimatedSlide(
              offset: _showControls ? Offset.zero : const Offset(0, 1),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              child: PlayerControls(
                state: playerState,
                onPlayPause: () => ref.read(playerProvider.notifier).togglePlayPause(),
                onSeek: (pos) => ref.read(playerProvider.notifier).seek(pos),
                onSpeed: (s) => ref.read(playerProvider.notifier).setSpeed(s),
                onVolume: (v) => ref.read(playerProvider.notifier).setVolume(v),
                onPickFile: _pickFile,
                onPickSubtitle: _pickSubtitle,
                onShowSubSettings: () => _showSubtitleSettings(context),
                onShowAudioTracks: () => _showAudioTracks(context),
              ),
            ),
          ),

          if (!_showControls)
            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              right: 16,
              child: _statusChip(playerState, roomState),
            ),

          if (isLandscape && _showChat)
            Positioned(
              right: 0, top: 0, bottom: 0, width: 380,
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                  child: Container(
                    decoration: BoxDecoration(color: AppColors.surfaceDark.withOpacity(0.88), border: Border(left: BorderSide(color: Colors.white.withOpacity(0.08)))),
                    child: ChatPanel(onClose: () => setState(() => _showChat = false)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _emptyPlayer() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.1))),
              child: const Icon(Icons.video_library_rounded, size: 36, color: Colors.white70),
            ),
            const Gap(20),
            const Text('هیچ فایلی انتخاب نشده', style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w600)),
            const Gap(8),
            const Text('فایل از حافظه دستگاه خود انتخاب کنید', style: TextStyle(color: Colors.white38, fontSize: 13)),
            const Gap(24),
            ElevatedButton.icon(onPressed: _pickFile, icon: const Icon(Icons.folder_open_rounded), label: const Text('انتخاب فایل'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
          ],
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context, RoomStateData roomState, bool isLandscape) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, left: 16, right: 16, bottom: 24),
      decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black.withOpacity(0.7), Colors.transparent], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Row(
        children: [
          _controlBtn(Icons.arrow_back_rounded, () => Navigator.pop(context)),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(roomState.room?.name ?? 'Room ${widget.roomId}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis),
                const Gap(2),
                Row(
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle)),
                    const Gap(6),
                    Text('${roomState.users.length} نفر • ${roomState.room?.allowAllControl == true ? 'کنترل همگانی' : 'فقط میزبان'}', style: const TextStyle(color: Colors.white60, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          _controlBtn(Icons.subtitles_rounded, () => _showSubtitleSettings(context)),
          const Gap(8),
          _controlBtn(Icons.chat_bubble_rounded, () {
            if (isLandscape) {
              setState(() => _showChat = !_showChat);
            } else {
              _showChatBottomSheet(context);
            }
          }),
          const Gap(8),
          _controlBtn(isLandscape ? Icons.fullscreen_exit_rounded : Icons.fullscreen_rounded, () {
            if (isLandscape) {
              SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
            } else {
              SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
            }
          }),
        ],
      ),
    );
  }

  Widget _statusChip(playerState, roomState) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.1))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: roomState.ping < 100 ? AppColors.success : roomState.ping < 300 ? AppColors.warning : AppColors.error, shape: BoxShape.circle)),
              const Gap(6),
              Text('${roomState.ping}ms • ${playerState.isPlaying ? 'در حال پخش' : 'متوقف'}', style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _controlBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white.withOpacity(0.12))), child: Icon(icon, color: Colors.white, size: 20)),
    );
  }

  void _showChatBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (_) => DraggableScrollableSheet(initialChildSize: 0.7, maxChildSize: 0.9, minChildSize: 0.4, builder: (_, ctrl) => ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(24)), child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), child: Container(color: AppColors.surfaceDark.withOpacity(0.95), child: ChatPanel(scrollController: ctrl))))));
  }

  void _showSubtitleSettings(BuildContext context) {
    showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (_) => const SubtitleSettingsSheet());
  }

  void _showAudioTracks(BuildContext context) {
    showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (_) => const AudioTrackSheet());
  }
}
