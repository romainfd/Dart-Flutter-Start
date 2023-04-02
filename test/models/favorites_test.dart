import 'package:english_words/english_words.dart';
import 'package:test/test.dart';
import 'package:namer_app/models/favorites.dart';

void main() {
  group('Testing Favorites', () {
    var pair = WordPair("Test", "Pair");
    var otherPair = WordPair("Test", "OtherPair");

    test('A new pair should be added', () {
      var favorites = Favorites();
      favorites.toggleFavorite(pair);
      expect(favorites.items.contains(pair), true);
    });

    test('Favorite should be found', () {
      var favorites = Favorites();
      favorites.toggleFavorite(pair);
      expect(favorites.isFavorite(pair), true);
    });

    test('Not favorite should not be found', () {
      var favorites = Favorites();
      favorites.toggleFavorite(pair);
      expect(favorites.isFavorite(otherPair), false);
    });

    test('Pair should be removed', () {
      var favorites = Favorites();
      favorites.toggleFavorite(pair);
      favorites.removeFavorite(pair);
      expect(favorites.isFavorite(pair), false);
    });
  });
}
