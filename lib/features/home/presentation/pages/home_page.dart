import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/storage/local_storage.dart';
import '../widgets/glow_orb.dart';
import '../widgets/premium_card.dart';
import '../widgets/recent_rooms_sheet.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with TickerProviderStateMixin {
  late AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recentRooms = LocalStorage.getRecentRooms();
    
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          // Background gradients
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0A0A12), Color(0xFF141422), Color(0xFF0A0A12)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // Glow orbs
          Positioned(top: -100, left: -80, child: GlowOrb(color: AppColors.primary.withOpacity(0.3), size: 300)),
          Positioned(bottom: 100, right: -100, child: GlowOrb(color: AppColors.secondary.withOpacity(0.25), size: 350)),
          Positioned(top: 300, right: 50, child: GlowOrb(color: AppColors.accentPink.withOpacity(0.15), size: 200)),

          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  floating: true,
                  pinned: false,
                  elevation: 0,
                  expandedHeight: 70,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 12)],
                              ),
                              child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 26),
                            ).animate().scale(delay: 200.ms, duration: 600.ms, curve: Curves.easeOutBack),
                            const Gap(12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Syncinema', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                                Text('سینما سینک', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textSecondaryDark)),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            _glassIconButton(Icons.qr_code_scanner_rounded, onTap: () => context.push(AppRoutes.scanQr)),
                            const Gap(10),
                            _glassIconButton(Icons.settings_rounded, onTap: () => context.push(AppRoutes.settings)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero Title
                        Text(
                          'تماشا و شنیدن\nهمزمان، با هم',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                            letterSpacing: -1,
                          ),
                        ).animate().fadeIn(delay: 100.ms, duration: 800.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),

                        const Gap(12),
                        Text(
                          'فایل از دستگاه خودت، همگامی از ما.\nفیلم و موسیقی رو با دوستانت همزمان ببین و بشنو',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondaryDark, height: 1.6),
                        ).animate().fadeIn(delay: 300.ms, duration: 800.ms).slideY(begin: 0.2, end: 0),

                        const Gap(32),

                        // Premium Action Cards
                        Row(
                          children: [
                            Expanded(
                              child: PremiumActionCard(
                                title: 'ساخت اتاق',
                                subtitle: 'میزبان شو',
                                icon: Icons.add_rounded,
                                gradient: AppColors.primaryGradient,
                                onTap: () => context.push(AppRoutes.createRoom),
                              ),
                            ),
                            const Gap(16),
                            Expanded(
                              child: PremiumActionCard(
                                title: 'ورود به اتاق',
                                subtitle: 'با کد دعوت',
                                icon: Icons.login_rounded,
                                gradient: AppColors.accentGradient,
                                onTap: () => context.push(AppRoutes.joinRoom),
                              ),
                            ),
                          ],
                        ).animate().fadeIn(delay: 500.ms, duration: 600.ms).slideY(begin: 0.15, end: 0),

                        const Gap(24),

                        // Invite with Link Card - Glass
                        _glassInviteCard(context).animate().fadeIn(delay: 600.ms, duration: 600.ms).slideY(begin: 0.15, end: 0),

                        const Gap(32),

                        // Recent Rooms
                        if (recentRooms.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('اتاق‌های اخیر', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                              TextButton(onPressed: () {}, child: const Text('مشاهده همه')),
                            ],
                          ),
                          const Gap(12),
                          SizedBox(
                            height: 90,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: recentRooms.length,
                              separatorBuilder: (_, __) => const Gap(12),
                              itemBuilder: (context, i) {
                                final roomId = recentRooms[i];
                                return RecentRoomChip(roomId: roomId);
                              },
                            ),
                          ),
                          const Gap(24),
                        ],

                        // Features grid
                        Text('چرا سینکینما؟', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                        const Gap(16),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          childAspectRatio: 1.35,
                          children: const [
                            FeatureCard(icon: Icons.bolt_rounded, title: 'تاخیر صفر', desc: 'همگامسازی با دقت میلی‌ثانیه', color: AppColors.primary),
                            FeatureCard(icon: Icons.subtitles_rounded, title: 'زیرنویس هوشمند', desc: 'فارسی، داخلی و خارجی', color: AppColors.secondary),
                            FeatureCard(icon: Icons.queue_music_rounded, title: 'فیلم و موسیقی', desc: 'MP4, MKV, MP3, FLAC', color: AppColors.accentPink),
                            FeatureCard(icon: Icons.security_rounded, title: 'کاملاً خصوصی', desc: 'فایل‌ها روی دستگاه شما', color: AppColors.accentOrange),
                          ],
                        ),

                        const Gap(100),
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

  Widget _glassIconButton(IconData icon, {VoidCallback? onTap}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Icon(icon, size: 20, color: Colors.white.withOpacity(0.9)),
          ),
        ),
      ),
    );
  }

  Widget _glassInviteCard(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.link_rounded, color: AppColors.primaryLight),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('دعوت با لینک', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                    const Gap(4),
                    Text('لینک اتاق را برای دوستانت بفرست و همزمان ببینید', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondaryDark)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white.withOpacity(0.4)),
            ],
          ),
        ),
      ),
    );
  }
}
