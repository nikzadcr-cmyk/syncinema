import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../../app/theme/colors.dart';
import '../../providers/player_provider.dart';

class SubtitleSettingsSheet extends ConsumerStatefulWidget {
  const SubtitleSettingsSheet({super.key});

  @override
  ConsumerState<SubtitleSettingsSheet> createState() => _SubtitleSettingsSheetState();
}

class _SubtitleSettingsSheetState extends ConsumerState<SubtitleSettingsSheet> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(playerProvider);
    final notifier = ref.read(playerProvider.notifier);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: AppColors.surfaceDark, borderRadius: const BorderRadius.vertical(top: Radius.circular(24))),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(4)))),
                const Gap(20),
                Text('تنظیمات زیرنویس', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const Gap(20),

                Text('سایز فونت: ${state.subtitleStyle.fontSize.toInt()}', style: Theme.of(context).textTheme.titleSmall),
                Slider(value: state.subtitleStyle.fontSize, min: 12, max: 36, divisions: 12, label: state.subtitleStyle.fontSize.toInt().toString(), activeColor: AppColors.primary, onChanged: (v) => notifier.updateSubtitleStyle(state.subtitleStyle.copyWith(fontSize: v))),

                const Gap(12),
                Text('تاخیر زیرنویس: ${state.subtitleStyle.delayMs}ms', style: Theme.of(context).textTheme.titleSmall),
                Slider(value: state.subtitleStyle.delayMs, min: -5000, max: 5000, divisions: 20, label: '${state.subtitleStyle.delayMs}ms', activeColor: AppColors.secondary, onChanged: (v) => notifier.updateSubtitleStyle(state.subtitleStyle.copyWith(delayMs: v))),

                const Gap(12),
                Text('زیرنویس‌های موجود', style: Theme.of(context).textTheme.titleSmall),
                const Gap(10),
                if (state.subtitleTracks.isEmpty)
                  Text('هیچ زیرنویسی یافت نشد', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondaryDark))
                else
                  Column(
                    children: state.subtitleTracks.map((t) => ListTile(
                      leading: Icon(Icons.subtitles_rounded, color: state.selectedSubtitle?.id == t.id ? AppColors.primary : AppColors.textSecondaryDark),
                      title: Text(t.title),
                      subtitle: Text(t.language),
                      trailing: state.selectedSubtitle?.id == t.id ? const Icon(Icons.check_rounded, color: AppColors.primary) : null,
                      onTap: () => notifier.selectSubtitleTrack(t),
                    )).toList(),
                  ),

                ListTile(
                  leading: const Icon(Icons.block_rounded, color: AppColors.error),
                  title: const Text('خاموش کردن زیرنویس'),
                  onTap: () => notifier.selectSubtitleTrack(null),
                ),

                const Gap(20),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('بستن'))),
                Gap(MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
