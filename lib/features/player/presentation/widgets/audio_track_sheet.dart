import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../../app/theme/colors.dart';
import '../../providers/player_provider.dart';
import '../../domain/entities/audio_track.dart';

class AudioTrackSheet extends ConsumerWidget {
  const AudioTrackSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playerProvider);
    final notifier = ref.read(playerProvider.notifier);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: AppColors.surfaceDark, borderRadius: const BorderRadius.vertical(top: Radius.circular(24))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(4)))),
              const Gap(20),
              Text('ترک‌های صوتی', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              const Gap(8),
              Text('اگر ویدیو چند زبان دارد اینجا انتخاب کنید', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondaryDark)),
              const Gap(20),

              if (state.audioTracks.isEmpty)
                Padding(padding: const EdgeInsets.all(20), child: Center(child: Text('هیچ ترک صوتی دیگری یافت نشد\n(تک زبانه)', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondaryDark))))
              else
                Column(
                  children: state.audioTracks.map((t) => _TrackTile(track: t, isSelected: state.selectedAudio?.id == t.id, onTap: () { notifier.selectAudioTrack(t); Navigator.pop(context); })).toList(),
                ),

              const Gap(16),
              SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('بستن'))),
              Gap(MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrackTile extends StatelessWidget {
  final AudioTrackInfo track;
  final bool isSelected;
  final VoidCallback onTap;
  const _TrackTile({required this.track, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: isSelected ? AppColors.primary.withOpacity(0.15) : Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(14), border: Border.all(color: isSelected ? AppColors.primary : Colors.white.withOpacity(0.06))),
        child: Row(
          children: [
            Container(width: 40, height: 40, decoration: BoxDecoration(color: isSelected ? AppColors.primary : AppColors.surfaceDark3, borderRadius: BorderRadius.circular(10)), child: Icon(Icons.audiotrack_rounded, color: isSelected ? Colors.white : AppColors.textSecondaryDark, size: 20)),
            const Gap(12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(track.title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, color: isSelected ? Colors.white : null)), const Gap(2), Text('${track.displayLanguage} • ${track.language}', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textSecondaryDark))])),
            if (isSelected) const Icon(Icons.check_circle_rounded, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
