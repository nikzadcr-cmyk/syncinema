import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncinema/features/home/presentation/pages/home_page.dart';

void main() {
  testWidgets('HomePage shows create and join buttons', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: HomePage()),
      ),
    );
    // Let animations complete to avoid timersPending
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(find.text('ساخت اتاق'), findsOneWidget);
    expect(find.text('ورود به اتاق'), findsOneWidget);
  });

  testWidgets('HomePage shows hero title', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: HomePage())),
    );
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(find.textContaining('همزمان'), findsWidgets);
    expect(find.textContaining('تماشا'), findsWidgets);
  });

  testWidgets('HomePage has Syncinema branding', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: HomePage())),
    );
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(find.text('Syncinema'), findsOneWidget);
  });
}
