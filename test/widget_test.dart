import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab1/lab4/lab4_app.dart';

void main() {
  testWidgets('Lab 4 home shows all exercises', (WidgetTester tester) async {
    await tester.pumpWidget(const Lab4App());

    expect(find.text('Lab 4 - Flutter UI Fundamentals'), findsOneWidget);
    expect(find.text('Exercise 1 - Core Widgets Demo'), findsOneWidget);
    expect(find.text('Exercise 2 - Input Controls Demo'), findsOneWidget);
    expect(find.text('Exercise 3 - Layout Demo'), findsOneWidget);
    expect(find.text('Exercise 4 - App Structure & Theme'), findsOneWidget);
    expect(find.text('Exercise 5 - Common UI Fixes'), findsOneWidget);
  });

  testWidgets('Exercise 2 date picker button is reachable', (tester) async {
    await tester.pumpWidget(const Lab4App());

    await tester.tap(find.text('Exercise 2 - Input Controls Demo'));
    await tester.pumpAndSettle();

    expect(find.text('Open Date Picker'), findsOneWidget);
    expect(find.text('Updated values'), findsOneWidget);
  });

  testWidgets('Exercise 4 dark mode can toggle on and off', (tester) async {
    await tester.pumpWidget(const Lab4App());

    await tester.tap(find.text('Exercise 4 - App Structure & Theme'));
    await tester.pumpAndSettle();

    expect(find.text('Light mode is enabled'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(find.text('Dark mode is enabled'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(find.text('Light mode is enabled'), findsOneWidget);
  });
}
