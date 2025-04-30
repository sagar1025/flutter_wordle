import 'dart:collection';

import 'package:flutter_wordle/grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordle/status_banner.dart';

class FormGridRow extends StatefulWidget {
  const FormGridRow({super.key});

  @override
  State<FormGridRow> createState() => _FormGridRowState();
}

class _FormGridRowState extends State<FormGridRow> {
  late String answer; //TODO: get this from the backend.
  late bool isGameOver;
  final int maxRows = 6; // number of chances/rows.

  late List<GlobalKey<FormState>> _formKeysList;
  late List<TextEditingController> _controllers;
  late List<GridItem> _textFields;
  late int activeRowIndex;
  late HashMap<int, Widget> _gridForms;

  @override
  void initState() {
    super.initState();
    answer = "WORLD";//TODO: get this from the backend.
    isGameOver = false;
    activeRowIndex = 0;

    _gridForms = HashMap<int, Widget>();
    _formKeysList = List.generate(maxRows, (index) => GlobalKey<FormState>());
    _controllers = List.generate(
      maxRows * 5,
      (index) => TextEditingController(),
    );
    _updateGridFormFields();
  }

  //rowIndex is the index of the index of the row to update.
  void _updateGridFormFields() {
    //generate a controller for each text field.
    //maxRows * 5 because each word has 5 letters.
    _textFields = List.generate(
      maxRows * 5,
      (index) => GridItem(
        index: index,
        isEnabled:
            index >= activeRowIndex * 5 && index < activeRowIndex * 5 + 5,
        controller: _controllers[index],
      ),
    );

    _gridForms.addEntries(
      List.generate(
        maxRows,
        (index) => MapEntry(
          index,
          Form(
            key: _formKeysList[index],
            child: Column(
              children: [
                Row(children: _textFields.sublist(index * 5, index * 5 + 5)),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void onPressed() {
    if (_formKeysList[activeRowIndex].currentState!.validate()) {
      int rowToCheck = activeRowIndex * 5;
      String word = _controllers
          .sublist(rowToCheck, rowToCheck + 5)
          .map((c) => c.text)
          .toList()
          .join("");

      //check word.
      if (word == answer) {
        _updateGridFormFields();
        setState(() {
          isGameOver = true;
          activeRowIndex += 1;
        });

        // return toast.
        ScaffoldMessenger.of(
          context,
        ).showMaterialBanner(StatusBanner(success: true, text: 'CORRECT!'));
      } else {
        if (activeRowIndex == maxRows - 1) {
          _updateGridFormFields();
          setState(() {
            isGameOver = true;
            activeRowIndex += 1;
          });

          //return toast.
          ScaffoldMessenger.of(context).showMaterialBanner(
            StatusBanner(
              success: false,
              text: 'GAME OVER! The answer is $answer',
            ),
          );
        } else {
          setState(() {
            activeRowIndex += 1;
          });
          _updateGridFormFields();
        }
      }
    }
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ..._gridForms.values,
          SizedBox(
            height: 45,
            width: 450,
            child: ElevatedButton(
              onPressed: () {
                isGameOver ? null : onPressed();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                backgroundColor:
                    isGameOver ? Colors.grey : Colors.green.shade500,
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}
