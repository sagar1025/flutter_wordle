import 'package:flutter/material.dart';
//import 'package:flutter_wordle/grid_item.dart';
import 'package:flutter_wordle/form_grid_row.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false, //prevents the app from resizing when keyboard is open/closed.
        appBar: AppBar(title: Center(child: Text("WORDLE"))),
        body: GridRowColumn(),
        // body: GridRowColumn(),
      ),
    ),
  );
}

class GridRowColumn extends StatelessWidget {
  const GridRowColumn({super.key});

  @override
  Widget build(context) {
    // final children = <Widget>[];
    // for (var i = 0; i < 5; i++) {
    //   children.add(FormGridRow(rowIndex: i));
    // }
    return FormGridRow();
  }
}
