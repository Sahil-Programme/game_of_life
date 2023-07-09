import 'package:flutter/material.dart';
import 'package:game_of_life/pages/game_page.dart';
import 'package:game_of_life/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game of life',
      initialRoute: HomePage.route,
      //initialRoute: GamePage.route,
      //initialRoute: TestScroll.route,

      routes: {
        HomePage.route: (context) => const HomePage(),
        GamePage.route: (context) => const GamePage(),
      },
    );
  }
}
