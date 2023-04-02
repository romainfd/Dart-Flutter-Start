import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:namer_app/main.dart';
import 'package:namer_app/views/generator.dart';

void main() {
  testWidgets('App starts', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('Test Navigation and Favorites data sharing',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Find the currently shown word pair.
    final wordPairTextWidgets = tester
        .widgetList<Text>(find.descendant(
          of: find.byType(BigCard),
          matching: find.byType(Text),
        ))
        .toList();
    final current = wordPairTextWidgets[0].data! + wordPairTextWidgets[1].data!;

    // Go to the Favorites page.
    await tester.tap(find.descendant(
      of: find.byType(NavigationRail),
      matching: find.byIcon(Icons.favorite),
    ));
    await tester.pumpAndSettle();

    // Not there yet.
    expect(find.text(current), findsNothing);

    // Go back to the Generator page.
    await tester.tap(find.descendant(
      of: find.byType(NavigationRail),
      matching: find.byIcon(Icons.home),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Like'));

    // Go to Favorites page once again.
    await tester.tap(find.descendant(
      of: find.byType(NavigationRail),
      matching: find.byIcon(Icons.favorite),
    ));
    await tester.pumpAndSettle();

    // Should be there.
    expect(find.text(current), findsOneWidget);
  });
}
