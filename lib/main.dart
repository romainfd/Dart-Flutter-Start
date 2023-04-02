import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/favorites.dart';
import 'models/history.dart';
import 'views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<History>(create: (_) => History()),
        ChangeNotifierProvider<Favorites>(create: (_) => Favorites()),
      ],
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: HomePage(),
      ),
    );
  }
}
