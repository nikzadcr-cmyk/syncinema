import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../app/theme/colors.dart';
import '../../providers/player_provider.dart';
import '../../../../core/utils/time_utils.dart';

class PlayerControls extends StatefulWidget {
  final PlayerState state;
  final VoidCallback onPlayPause;
  final void Function(Duration) onSeek;
  final void Function(double) onSpeed;
  final void Function(double) onVolume;
  final VoidCallback onPickFile;
  final VoidCallback onPickSubtitle;
  final VoidCallback onShowSubSettings;
  final VoidCallback onShowAudioTracks;

  const PlayerControls({
    super.key,
    required this.state,
    required this.onPlayPause,
    required this.onSeek,
    required this.onSpeed,
    required this.onVolume,
    required this.onPickFile,
    required this.onPickSubtitle,
    required this.onShowSubSettings,
    required this.onShowAudioTracks,
  });

  @override
  State<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  double _dragValue = 0;
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    final pos = widget.state.position;
    final dur = widget.state.duration.inMilliseconds > 0 ? widget.state.duration : const Duration(hours: 2);
    final progress = dur.inMilliseconds == 0 ? 0.0 : (pos.inMilliseconds / dur.inMilliseconds).clamp(0.0, 1.0);
    final displayPos = _dragging ? Duration(milliseconds: (_dragValue * dur.inMilliseconds).toInt()) : pos;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16 + 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.black.withOpacity(0.0), Colors.black.withOpacity(0.85)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            border: Border(top: BorderSide(color: Colors.white.withOpacity(0.06))),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Progress bar with time
                Row(
                  children: [
                    Text(TimeUtils.formatDuration(displayPos), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, fontFeatures: [FontFeature.tabularFigures()])),
                    const Gap(12),
                    Expanded(
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 3,
                          activeTrackColor: AppColors.primary,
                          inactiveTrackColor: Colors.white.withOpacity(0.15),
                          thumbColor: Colors.white,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                        ),
                        child: Slider(
                          value: _dragging ? _dragValue : progress,
                          onChanged: (v) {
                            setState(() { _dragging = true; _dragValue = v; });
                          },
                          onChangeEnd: (v) {
                            final newPos = Duration(milliseconds: (v * dur.inMilliseconds).toInt());
                            widget.onSeek(newPos);
                            setState(() => _dragging = false);
                          },
                        ),
                      ),
                    ),
                    const Gap(12),
                    Text(TimeUtils.formatDuration(dur), style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12, fontFeatures: const [FontFeature.tabularFigures()])),
                  ],
                ),

                const Gap(12),

                // Main controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _iconBtn(Icons.skip_previous_rounded, () => widget.onSeek(pos - const Duration(seconds: 10))),
                        const Gap(6),
                        Container(
                          decoration: BoxDecoration(gradient: AppColors.primaryGradient, shape: BoxShape.circle, boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 12)]),
                          child: IconButton(onPressed: widget.onPlayPause, icon: Icon(widget.state.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.white, size: 28), iconSize: 28, padding: const EdgeInsets.all(10)),
                        ),
                        const Gap(6),
                        _iconBtn(Icons.skip_next_rounded, () => widget.onSeek(pos + const Duration(seconds: 10))),
                        const Gap(16),
                        _smallBtn('${widget.state.speed.toStringAsFixed(widget.state.speed % 1 == 0 ? 0 : 1)}x', () => _showSpeedSheet(context)),
                      ],
                    ),

                    Row(
                      children: [
                        _iconBtn(Icons.folder_open_rounded, widget.onPickFile),
                        const Gap(8),
                        _iconBtn(Icons.audiotrack_rounded, widget.onShowAudioTracks),
                        const Gap(8),
                        _iconBtn(Icons.subtitles_rounded, widget.onPickSubtitle),
                        const Gap(8),
                        _iconBtn(Icons.settings_rounded, widget.onShowSubSettings),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(width: 38, height: 38, decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white.withOpacity(0.08))), child: Icon(icon, color: Colors.white.withOpacity(0.9), size: 18)),
    );
  }

  Widget _smallBtn(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(8)), child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700))),
    );
  }

  void _showSpeedSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: AppColors.surfaceDark, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(4))),
                const Gap(20),
                Text('سرعت پخش', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const Gap(16),
                Wrap(
                  spacing: 10,
                  children: [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0].map((s) => ChoiceChip(label: Text('${s}x'), selected: widget.state.speed == s, onSelected: (_) { widget.onSpeed(s); Navigator.pop(context); })).toList(),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
