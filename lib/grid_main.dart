import 'package:flutter/material.dart';
import 'package:flutter_wordle/form_grid_row.dart';

class GridMain extends StatelessWidget {
  const GridMain({super.key});

  @override
  Widget build(context) {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    return (Scaffold(
      resizeToAvoidBottomInset:
          false, //prevents the app from resizing when keyboard is open/closed.
      appBar: AppBar(title: Center(child: Text("WORDLE"))),
      body: FormGridRow(),
    ));
  }
}
