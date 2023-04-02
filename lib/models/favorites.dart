import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

/// The [Favorites] class holds a list of favorite items saved by the user.
class Favorites extends ChangeNotifier {
  var _favoriteItems = <WordPair>[];

  /// The list of favorite items.
  List<WordPair> get items => _favoriteItems;

  /// Toggles the favorite status of a [WordPair].
  ///
  /// ```dart
  /// var favorites = Favorites();
  /// var pair = WordPair("Test", "Pair");
  /// favorites.toggleFavorite(pair);
  /// expect(favorites.isFavorite(pair), true);
  /// favorites.toggleFavorite(pair);
  /// expect(favorites.isFavorite(pair), false);
  /// ```
  void toggleFavorite(WordPair pair) {
    if (_favoriteItems.contains(pair)) {
      _favoriteItems.remove(pair);
    } else {
      _favoriteItems.add(pair);
    }
    notifyListeners();
  }

  /// Removes a [WordPair] from the list of favorites.
  ///
  /// ```dart
  /// var favorites = Favorites();
  /// var pair = WordPair("Test", "Pair");
  /// favorites.toggleFavorite(pair);
  /// expect(favorites.isFavorite(pair), true);
  /// favorites.removeFavorite(pair);
  /// expect(favorites.isFavorite(pair), false);
  /// ```
  void removeFavorite(WordPair pair) {
    _favoriteItems.remove(pair);
    notifyListeners();
  }

  /// Checks if a [WordPair] is a favorite.
  ///
  /// ```dart
  /// var favorites = Favorites();
  /// var pair = WordPair("Test", "Pair");
  /// var otherPair = WordPair("Test", "OtherPair");
  /// favorites.toggleFavorite(pair);
  /// expect(favorites.isFavorite(pair), true);
  /// expect(favorites.isFavorite(otherPair), false);
  /// ```
  bool isFavorite(WordPair pair) {
    return _favoriteItems.contains(pair);
  }
}
