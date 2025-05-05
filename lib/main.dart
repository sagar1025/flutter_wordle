import 'package:flutter/material.dart';
import 'package:flutter_wordle/grid_main.dart';
import 'package:flutter_wordle/game_menu.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  // To load the .env file contents into dotenv.

  await dotenv.load(fileName: ".env");
  runApp(
    MaterialApp(
      home: Navigator(
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => GameMenu());
            case '/start':
              return MaterialPageRoute(builder: (_) => GridMain());
            default:
              return MaterialPageRoute(builder: (_) => GameMenu());
          }
        },
      ),
    ),
  );
}
