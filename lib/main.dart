import 'package:flutter/material.dart';
import 'package:flutter_wordle/grid_main.dart';
import 'package:flutter_wordle/game_menu.dart';

void main() {
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