import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import '../../../../app/theme/colors.dart';
import '../providers/room_provider.dart';
import '../../../home/presentation/widgets/glow_orb.dart';

class JoinRoomPage extends ConsumerStatefulWidget {
  final String? prefilledRoomId;
  const JoinRoomPage({super.key, this.prefilledRoomId});

  @override
  ConsumerState<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends ConsumerState<JoinRoomPage> {
  final _roomIdCtrl = TextEditingController();
  final _userNameCtrl = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.prefilledRoomId != null) _roomIdCtrl.text = widget.prefilledRoomId!;
    _userNameCtrl.text = 'کاربر ${DateTime.now().second}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          Positioned.fill(child: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF0A0A12), Color(0xFF1A1A2E)], begin: Alignment.topCenter, end: Alignment.bottomCenter)))),
          Positioned(top: -60, right: -60, child: GlowOrb(color: AppColors.secondary.withOpacity(0.2), size: 280)),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      _glassBtn(Icons.arrow_back_rounded, () => context.pop()),
                      const Gap(16),
                      Text('ورود به اتاق', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                      const Spacer(),
                      _glassBtn(Icons.qr_code_scanner_rounded, () => context.push('/scan-qr')),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(10),
                        Text('کد اتاق را وارد کن\nو به جمع بپیوند', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, height: 1.3)),
                        const Gap(30),
                        _label('کد اتاق (6 کاراکتر)'),
                        const Gap(10),
                        _codeField(),
                        const Gap(22),
                        _label('نام شما'),
                        const Gap(10),
                        _textField(_userNameCtrl, 'نام نمایشی', Icons.person_rounded),
                        const Gap(40),
                        SizedBox(
                          width: double.infinity, height: 58,
                          child: ElevatedButton(
                            onPressed: _loading ? null : _join,
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                            child: _loading ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2) : Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.login_rounded), const Gap(10), Text('ورود به اتاق', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w800))]),
                          ),
                        ),
                        const Gap(16),
                        Center(child: TextButton(onPressed: () => context.push('/scan-qr'), child: const Text('یا با QR Code وارد شو'))),
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

  Widget _codeField() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: TextField(
          controller: _roomIdCtrl,
          textCapitalization: TextCapitalization.characters,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(letterSpacing: 6, fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
          maxLength: 6,
          decoration: InputDecoration(
            counterText: '',
            hintText: 'ABC123',
            hintStyle: TextStyle(letterSpacing: 6, color: Colors.white.withOpacity(0.2)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.white.withOpacity(0.08))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.white.withOpacity(0.08))),
            focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: AppColors.secondary, width: 1.5)),
          ),
        ),
      ),
    );
  }

  Widget _textField(TextEditingController c, String hint, IconData icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: TextField(
          controller: c,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20, color: AppColors.textSecondaryDark),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.white.withOpacity(0.08))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.white.withOpacity(0.08))),
            focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: AppColors.primary, width: 1.5)),
          ),
        ),
      ),
    );
  }

  Widget _glassBtn(IconData icon, VoidCallback onTap) {
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

  Future<void> _join() async {
    final code = _roomIdCtrl.text.trim().toUpperCase();
    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('کد باید 6 کاراکتر باشد')));
      return;
    }
    if (_userNameCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('نام را وارد کن')));
      return;
    }
    setState(() => _loading = true);
    try {
      await ref.read(roomProvider.notifier).joinRoom(roomId: code, userName: _userNameCtrl.text.trim());
      if (mounted) context.go('/room/$code');
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطا در ورود: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
}
