import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:gap/gap.dart';
import '../../../../app/theme/colors.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final _controller = MobileScannerController();
  bool _handled = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_handled) return;
    final barcode = capture.barcodes.firstOrNull;
    final raw = barcode?.rawValue;
    if (raw == null) return;

    // Try to parse roomId from URL or plain code
    String? roomId;
    if (raw.contains('roomId=')) {
      final uri = Uri.tryParse(raw);
      roomId = uri?.queryParameters['roomId'];
    } else if (RegExp(r'^[A-Z0-9]{6}$').hasMatch(raw.toUpperCase())) {
      roomId = raw.toUpperCase();
    } else {
      // Maybe link https://syncinema.app/join?roomId=ABC123
      final match = RegExp(r'[A-Z0-9]{6}').firstMatch(raw.toUpperCase());
      roomId = match?.group(0);
    }

    if (roomId != null) {
      _handled = true;
      context.go('/join-room?roomId=$roomId');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(controller: _controller, onDetect: _onDetect),

          // Overlay
          Positioned.fill(
            child: CustomPaint(painter: _ScannerOverlayPainter()),
          ),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: InkWell(
                            onTap: () => context.pop(),
                            child: Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white.withOpacity(0.1))), child: const Icon(Icons.arrow_back_rounded, color: Colors.white)),
                          ),
                        ),
                      ),
                      const Gap(12),
                      const Text('اسکن QR Code', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.1))),
                        child: Row(
                          children: [
                            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.qr_code_rounded, color: Colors.white)),
                            const Gap(12),
                            const Expanded(child: Text('QR Code اتاق را در کادر قرار دهید تا به صورت خودکار وارد شوید', style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(MediaQuery.of(context).padding.bottom + 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.6);
    final cutOutSize = size.width * 0.7;
    final left = (size.width - cutOutSize) / 2;
    final top = (size.height - cutOutSize) / 2 - 40;
    final rect = Rect.fromLTWH(left, top, cutOutSize, cutOutSize);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(20));

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(rrect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);

    // Corners
    final cornerPaint = Paint()..color = AppColors.primary..style = PaintingStyle.stroke..strokeWidth = 4..strokeCap = StrokeCap.round;
    const cornerLen = 30.0;

    // TL
    canvas.drawPath(Path()..moveTo(left, top + cornerLen)..lineTo(left, top)..lineTo(left + cornerLen, top), cornerPaint);
    // TR
    canvas.drawPath(Path()..moveTo(left + cutOutSize - cornerLen, top)..lineTo(left + cutOutSize, top)..lineTo(left + cutOutSize, top + cornerLen), cornerPaint);
    // BL
    canvas.drawPath(Path()..moveTo(left, top + cutOutSize - cornerLen)..lineTo(left, top + cutOutSize)..lineTo(left + cornerLen, top + cutOutSize), cornerPaint);
    // BR
    canvas.drawPath(Path()..moveTo(left + cutOutSize - cornerLen, top + cutOutSize)..lineTo(left + cutOutSize, top + cutOutSize)..lineTo(left + cutOutSize, top + cutOutSize - cornerLen), cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
