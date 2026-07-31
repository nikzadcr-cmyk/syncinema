import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/storage/local_storage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _subtitleSize = 16;
  bool _autoSync = true;

  @override
  void initState() {
    super.initState();
    _subtitleSize = LocalStorage.getSubtitleSize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          Positioned.fill(child: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF0A0A12), Color(0xFF15152A)], begin: Alignment.topCenter, end: Alignment.bottomCenter)))),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  pinned: true,
                  leading: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: InkWell(
                          onTap: () => context.pop(),
                          child: Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.arrow_back_rounded, size: 20)),
                        ),
                      ),
                    ),
                  ),
                  title: const Text('تنظیمات', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle('پخش'),
                        _glassCard(
                          children: [
                            _tile(icon: Icons.speed_rounded, title: 'همگام‌سازی خودکار', subtitle: 'اصلاح خودکار اختلاف زمانی', trailing: Switch(value: _autoSync, onChanged: (v) => setState(() => _autoSync = v))),
                            Divider(color: Colors.white.withOpacity(0.06), height: 1),
                            _tile(icon: Icons.subtitles_rounded, title: 'سایز زیرنویس', subtitle: '${_subtitleSize.toInt()}', trailing: SizedBox(width: 120, child: Slider(value: _subtitleSize, min: 12, max: 32, activeColor: AppColors.primary, onChanged: (v) { setState(() => _subtitleSize = v); LocalStorage.setSubtitleSize(v); }))),
                          ],
                        ),
                        const Gap(20),
                        _sectionTitle('درباره'),
                        _glassCard(
                          children: [
                            _tile(icon: Icons.info_rounded, title: 'نسخه برنامه', subtitle: 'Syncinema 1.0.0 (Production)', trailing: const Icon(Icons.verified_rounded, color: AppColors.success)),
                            Divider(color: Colors.white.withOpacity(0.06), height: 1),
                            _tile(icon: Icons.security_rounded, title: 'حریم خصوصی', subtitle: 'فایل‌ها فقط روی دستگاه شما', trailing: const Icon(Icons.lock_rounded, size: 18)),
                            Divider(color: Colors.white.withOpacity(0.06), height: 1),
                            _tile(icon: Icons.code_rounded, title: 'توسعه‌دهنده', subtitle: 'تیم Syncinema - Flutter + Cloudflare', trailing: const Icon(Icons.favorite_rounded, color: AppColors.accentPink, size: 18)),
                          ],
                        ),
                        const Gap(20),
                        _sectionTitle('اتصال'),
                        _glassCard(
                          children: [
                            _tile(icon: Icons.cloud_rounded, title: 'سرور', subtitle: 'Cloudflare Workers + Durable Objects', trailing: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: AppColors.success.withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: const Text('متصل', style: TextStyle(color: AppColors.success, fontSize: 11, fontWeight: FontWeight.w700)))),
                            Divider(color: Colors.white.withOpacity(0.06), height: 1),
                            _tile(icon: Icons.bolt_rounded, title: 'پروتکل', subtitle: 'WebSocket Realtime + Heartbeat', trailing: const Icon(Icons.flash_on_rounded, color: AppColors.warning)),
                          ],
                        ),
                        const Gap(40),
                        Center(child: Text('ساخته شده با ❤️ برای تماشای با هم', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondaryDark))),
                        const Gap(20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String t) => Padding(padding: const EdgeInsets.only(bottom: 12, left: 4), child: Text(t, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.textSecondaryDark, fontWeight: FontWeight.w700)));

  Widget _glassCard({required List<Widget> children}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.06))), child: Column(children: children)),
      ),
    );
  }

  Widget _tile({required IconData icon, required String title, required String subtitle, Widget? trailing}) {
    return ListTile(
      leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.12), borderRadius: BorderRadius.circular(10)), child: Icon(icon, size: 18, color: AppColors.primaryLight)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textSecondaryDark, fontSize: 12)),
      trailing: trailing,
    );
  }
}
