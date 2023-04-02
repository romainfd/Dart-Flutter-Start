import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

/// The [Favorites] class holds a list of favorite items saved by the user.
class Favorites extends ChangeNotifier {
  var _favoriteItems = <WordPair>[];

  List<WordPair> get items => _favoriteItems;

  void toggleFavorite(WordPair pair) {
    if (_favoriteItems.contains(pair)) {
      _favoriteItems.remove(pair);
    } else {
      _favoriteItems.add(pair);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    _favoriteItems.remove(pair);
    notifyListeners();
  }

  bool isFavorite(WordPair pair) {
    return _favoriteItems.contains(pair);
  }
}
