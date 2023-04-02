import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/models/favorites.dart';
import 'package:namer_app/views/favorites.dart';
import 'package:provider/provider.dart';

late Favorites favorites;
var pair = WordPair("Test", "Pair");

Widget createFavoritesPage() => ChangeNotifierProvider<Favorites>(
      create: (context) {
        favorites = Favorites();
        favorites.toggleFavorite(pair);
        return favorites;
      },
      child: MaterialApp(
        home: Scaffold(body: FavoritesPage()),
      ),
    );

void main() {
  group('Favorites Page tests', () {
    testWidgets('Liked word pair should shows up', (WidgetTester tester) async {
      await tester.pumpWidget(createFavoritesPage());

      expect(find.text(pair.asLowerCase), findsOneWidget);
    });
  });
}
