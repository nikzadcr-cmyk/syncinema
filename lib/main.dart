import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'core/di/injection.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Init media_kit
  MediaKit.ensureInitialized();
  
  // Init DI & Storage
  await initInjection();
  
  runApp(
    const ProviderScope(
      child: SyncinemaApp(),
    ),
  );
}
