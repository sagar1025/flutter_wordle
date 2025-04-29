//import 'dart:collection';

import 'package:flutter_wordle/grid_item.dart';
import 'package:flutter/material.dart';

class FormGridRow extends StatefulWidget {
  const FormGridRow({super.key});

  @override
  State<FormGridRow> createState() => _FormGridRowState();
}

class _FormGridRowState extends State<FormGridRow> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<TextEditingController> _controllers;
  late bool _isEnabled = true;
  late final bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(5, (index) => TextEditingController());
  }

  void saveValue(int index, String text) {
    _controllers[index].text = text;
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void onPressed() {
    if (_formKey.currentState!.validate()) {
      //disable the text fields
      setState(() {
        _isEnabled = false;
      });
      // for (int i = 0; i < _controllers.length; i++) {
      //   print('Text field $i: ${_controllers[i].text}');
      // }

      String word = _controllers.map((c) => c.text).toList().join("");
      //print('All values: $word');

      //check word.
    }
  }

  List<Widget> generateTextFields() {
    return List.generate(
      5,
      (index) => GridItem(
        index: index,
        isEnabled: _isEnabled,
        controller: _controllers[index],
      ),
    );
  }

  @override
  Widget build(context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(children: generateTextFields()),
              SizedBox(height: 10),
              SizedBox(
                height: 45,
                width: 450,
                child: ElevatedButton(
                  onPressed: () {
                    onPressed();
                  },
                  //enabled: false,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    backgroundColor: Colors.green.shade500,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      );
  }
}

// GridView.builder(
//         primary: false,
//         padding: const EdgeInsets.only(left: 35, right: 35),
//         //crossAxisSpacing: 10,
//         //mainAxisSpacing: 10,
//         //crossAxisCount: 5,
//         //children: [...textFields],
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 5,
//         ),
//         itemCount: 5,
//         itemBuilder: (context, ix) {
//           return GridItem(index: ix);
//         },
//       ),
