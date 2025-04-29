import 'package:flutter/material.dart';
//import 'package:flutter_wordle/grid_item.dart';
import 'package:flutter_wordle/form_grid_row.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
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
/*
class ContainerRow extends StatelessWidget {
  const ContainerRow({super.key});

  @override
  Widget build(context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: ContainerColumn(message: "Hey"),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.green)),
          child: ContainerColumn(message: "wyyyoo"),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
          child: Row(children: [Text("Hello World Row!!!!")]),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
          child: Row(children: [Text("Hello World Row 2!")]),
        ),
      ],
    );
  }
}

class ContainerColumn extends StatelessWidget {

  final String message;

  const ContainerColumn({required this.message, super.key});

  @override
  Widget build(context) {
    return Column(children: [Text(message)]);
  }
}
*/