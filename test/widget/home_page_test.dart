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
    await tester.pump();

    expect(find.text('ساخت اتاق'), findsOneWidget);
    expect(find.text('ورود به اتاق'), findsOneWidget);
  });

  testWidgets('HomePage shows hero title', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: HomePage())),
    );
    await tester.pump();

    expect(find.textContaining('همزمان'), findsOneWidget);
  });
}
