import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/models/favorites.dart';
import 'package:namer_app/models/history.dart';
import 'package:namer_app/views/generator.dart';
import 'package:provider/provider.dart';

late History history;
late Favorites favorites;

Widget createGeneratorPage() => MultiProvider(
      providers: [
        ChangeNotifierProvider<History>(create: (context) {
          history = History();
          // Call getNext 20 times to populate the history
          for (var i = 0; i < 20; i++) {
            history.getNext();
          }
          return history;
        }),
        ChangeNotifierProvider<Favorites>(create: (context) {
          favorites = Favorites();
          return favorites;
        }),
      ],
      child: MaterialApp(
        home: GeneratorPage(),
      ),
    );

void main() {
  group('Generator Page tests related to History', () {
    testWidgets('AnimatedList should show up', (tester) async {
      await tester.pumpWidget(createGeneratorPage());
      await tester.pumpAndSettle(); // wait for animations to finish
      expect(find.byType(AnimatedList), findsOneWidget);
    });

    testWidgets('Testing Scrolling', (tester) async {
      await tester.pumpWidget(createGeneratorPage());
      await tester.pumpAndSettle(); // wait for animations to finish

      var recentPair = history.items[2].asLowerCase;
      expect(find.text(recentPair), findsOneWidget);

      await tester.fling(
        find.byType(AnimatedList),
        const Offset(0, 200),
        3000,
      );
      await tester.pumpAndSettle();
      expect(find.text(recentPair), findsNothing);
    });

    testWidgets('Tapping button changes word pair',
        (WidgetTester tester) async {
      await tester.pumpWidget(createGeneratorPage());
      await tester.pumpAndSettle(); // wait for animations to finish

      // Tap several times and keep a list of word pair values.
      const tryCount = 5;
      final pairs = <String>[
        history.current.asLowerCase,
      ];
      for (var i = 1; i < tryCount; i++) {
        await tester.tap(find.text('Next'));
        await tester.pumpAndSettle(); // wait for animations to finish
        pairs.add(history.current.asLowerCase);
      }

      expect(
        // Converting the list to a set to remove duplicates.
        pairs.toSet(),
        // An occassional duplicate word pair is okay and expected.
        // We only fail this test when there is zero variance - all the
        // word pairs are the same, even though we clicked 'Next' several times.
        hasLength(greaterThan(1)),
        reason: 'After clicking $tryCount times, '
            'the app should have generated at least two different word pairs. '
            'Instead, the app showed these: $pairs. '
            'That almost certainly means that the word pair is not being '
            'randomly generated at all. The button does not work.',
      );
    });
  });

  group('Generator Page tests related to Favorites', () {
    testWidgets('Tapping "Like" changes icon', (WidgetTester tester) async {
      await tester.pumpWidget(createGeneratorPage());

      Finder findElevatedButtonByIcon(IconData icon) {
        return find.descendant(
          of: find.bySubtype<ElevatedButton>(),
          matching: find.byIcon(icon),
        );
      }

      // At start: an outlined heart icon.
      expect(findElevatedButtonByIcon(Icons.favorite_border), findsOneWidget);
      expect(findElevatedButtonByIcon(Icons.favorite), findsNothing);

      await tester.tap(find.text('Like'));
      await tester.pumpAndSettle();

      // After tap: a full heart icon.
      expect(findElevatedButtonByIcon(Icons.favorite_border), findsNothing);
      expect(findElevatedButtonByIcon(Icons.favorite), findsOneWidget);
    });
  });
}
