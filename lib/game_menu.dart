import 'package:flutter/material.dart';

class GameMenu extends StatelessWidget {
  const GameMenu({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Center(child: Text("WORDLE"))),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/start');
              },
              child: Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}