import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncinema/app/app.dart';

void main() {
  testWidgets('App loads HomePage', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: SyncinemaApp()));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.textContaining('Syncinema'), findsWidgets);
  });
}
