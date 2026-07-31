import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/router/routes.dart';
import '../providers/room_provider.dart';
import '../../../home/presentation/widgets/glow_orb.dart';

class CreateRoomPage extends ConsumerStatefulWidget {
  const CreateRoomPage({super.key});

  @override
  ConsumerState<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends ConsumerState<CreateRoomPage> {
  final _roomNameCtrl = TextEditingController(text: 'اتاق من');
  final _userNameCtrl = TextEditingController();
  bool _isMusicMode = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _userNameCtrl.text = 'کاربر ${DateTime.now().second}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF0A0A12), Color(0xFF1A1A2E)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
          ),
          Positioned(top: -80, right: -80, child: GlowOrb(color: AppColors.primary.withOpacity(0.25), size: 280)),
          Positioned(bottom: -50, left: -50, child: GlowOrb(color: AppColors.accentPink.withOpacity(0.2), size: 250)),

          SafeArea(
            child: Column(
              children: [
                // AppBar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      _glassIconButton(Icons.arrow_back_rounded, onTap: () => context.pop()),
                      const Gap(16),
                      Text('ساخت اتاق جدید', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(12),
                        Text('یک فضای جدید بساز\nو دوستانت را دعوت کن', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, height: 1.3)).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),

                        const Gap(30),

                        // Room name
                        _label('نام اتاق'),
                        const Gap(8),
                        _glassTextField(controller: _roomNameCtrl, hint: 'مثلا: فیلم جمعه شب', icon: Icons.meeting_room_rounded),

                        const Gap(20),
                        _label('نام شما'),
                        const Gap(8),
                        _glassTextField(controller: _userNameCtrl, hint: 'نام نمایشی شما', icon: Icons.person_rounded),

                        const Gap(24),

                        // Mode selector
                        _label('حالت اتاق'),
                        const Gap(12),
                        Row(
                          children: [
                            Expanded(
                              child: _modeCard(
                                selected: !_isMusicMode,
                                icon: Icons.movie_rounded,
                                title: 'فیلم',
                                desc: 'تماشای ویدیو',
                                onTap: () => setState(() => _isMusicMode = false),
                              ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: _modeCard(
                                selected: _isMusicMode,
                                icon: Icons.music_note_rounded,
                                title: 'موسیقی',
                                desc: 'گوش دادن',
                                onTap: () => setState(() => _isMusicMode = true),
                              ),
                            ),
                          ],
                        ),

                        const Gap(32),

                        // Info glass
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.primary.withOpacity(0.15))),
                              child: Row(
                                children: [
                                  Icon(Icons.info_rounded, color: AppColors.primaryLight, size: 20),
                                  const Gap(12),
                                  Expanded(child: Text('هیچ فایلی آپلود نمی‌شود. هر کاربر فایل خودش را از حافظه انتخاب می‌کند و فقط زمان پخش همگام می‌شود.', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondaryDark, height: 1.5))),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const Gap(40),

                        // Create button
                        SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _createRoom,
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0),
                            child: _isLoading
                                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.rocket_launch_rounded),
                                      const Gap(10),
                                      Text('ساخت اتاق', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
                                    ],
                                  ),
                          ),
                        ),
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

  Widget _label(String t) => Text(t, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, color: AppColors.textSecondaryDark));

  Widget _glassTextField({required TextEditingController controller, required String hint, required IconData icon}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: TextField(
          controller: controller,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20, color: AppColors.textSecondaryDark),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.white.withOpacity(0.08))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.white.withOpacity(0.08))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
          ),
        ),
      ),
    );
  }

  Widget _modeCard({required bool selected, required IconData icon, required String title, required String desc, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withOpacity(0.15) : Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? AppColors.primary : Colors.white.withOpacity(0.06), width: selected ? 1.5 : 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: selected ? AppColors.primaryLight : AppColors.textSecondaryDark, size: 28),
            const Gap(10),
            Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, color: selected ? Colors.white : AppColors.textSecondaryDark)),
            const Gap(4),
            Text(desc, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textSecondaryDark)),
          ],
        ),
      ),
    );
  }

  Widget _glassIconButton(IconData icon, {VoidCallback? onTap}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: InkWell(
          onTap: onTap,
          child: Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withOpacity(0.1))), child: Icon(icon, size: 20)),
        ),
      ),
    );
  }

  Future<void> _createRoom() async {
    if (_roomNameCtrl.text.trim().isEmpty || _userNameCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('لطفا همه فیلدها را پر کنید')));
      return;
    }
    setState(() => _isLoading = true);
    try {
      final roomId = await ref.read(roomProvider.notifier).createRoom(roomName: _roomNameCtrl.text.trim(), userName: _userNameCtrl.text.trim(), isMusicMode: _isMusicMode);
      if (mounted) context.go('/room/$roomId');
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطا: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
