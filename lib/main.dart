import 'package:flutter/material.dart';
import 'package:flutter_wordle/form_grid_row.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false, //prevents the app from resizing when keyboard is open/closed.
        appBar: AppBar(title: Center(child: Text("WORDLE"))),
        body: GridRowColumn(),
      ),
    ),
  );
}

class GridRowColumn extends StatelessWidget {
  const GridRowColumn({super.key});

  @override
  Widget build(context) {
    return FormGridRow();
  }
}
