import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorites.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var favorites = context.watch<Favorites>();

    if (favorites.items.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text('You have '
              '${favorites.items.length} favorites:'),
        ),
        Expanded(
          // Make better use of wide windows with a grid.
          child: GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 400 / 80,
            ),
            children: [
              for (var pair in favorites.items)
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.delete_outline, semanticLabel: 'Delete'),
                    color: theme.colorScheme.primary,
                    onPressed: () {
                      favorites.removeFavorite(pair);
                    },
                  ),
                  title: Text(
                    pair.asLowerCase,
                    semanticsLabel: pair.asPascalCase,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
