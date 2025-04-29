import 'dart:collection';

import 'package:flutter_wordle/grid_item.dart';
import 'package:flutter/material.dart';

class FormGridRow extends StatefulWidget {
  const FormGridRow({super.key});

  @override
  State<FormGridRow> createState() => _FormGridRowState();
}

class _FormGridRowState extends State<FormGridRow> {
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<GlobalKey<FormState>> _formKeysList;
  late List<TextEditingController> _controllers;
  late List<Widget> _textFields;
  late List<bool> _enabledStates;
  late bool _isCorrect;
  late int activeRowStartIndex;
  late int rowIndex;
  late HashMap<int, Widget> _gridForms;

  @override
  void initState() {
    super.initState();
    _formKeysList = List.generate(6, (index) => GlobalKey<FormState>());

    activeRowStartIndex = 0;
    _gridForms = HashMap<int, Widget>();

    _controllers = List.generate(30, (index) => TextEditingController());
    _enabledStates = List.generate(
      30,
      (index) => index < activeRowStartIndex + 5,
    );
    _textFields = List.generate(
      30,
      (index) => GridItem(
        index: index,
        isEnabled: _enabledStates[index],
        controller: _controllers[index],
      ),
    );

    _gridForms.addEntries(
      List.generate(
        6,
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

    rowIndex = 0;
    _isCorrect = false;
  }

  bool isRowEnabled(int index) {
    print("new indexxx");
    print(activeRowStartIndex);
    return index >= activeRowStartIndex && index < activeRowStartIndex + 5;
  }

  void saveValue(int index, String text) {
    _controllers[index].text = text;
  }

  //TODO....
  void setEnabled(int index, bool enabled) {
    setState(() {
      _enabledStates[index] = enabled;
      _textFields[index] = GridItem(
        index: index,
        isEnabled: enabled,
        controller: _controllers[index],
      );
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void onPressed() {
    //if (_formKey.currentState!.validate()) {
    //disable the text fields
    // setState(() {
    //   _isEnabled = false;
    // });
    // for (int i = 0; i < _controllers.length; i++) {
    //   print('Text field $i: ${_controllers[i].text}');
    // }

    if (_formKeysList[rowIndex].currentState!.validate()) {
      String word = _controllers
          .sublist(activeRowStartIndex, activeRowStartIndex + 5)
          .map((c) => c.text)
          .toList()
          .join("");
      print('All values: $word');
      const answer = "PILOT";
      //check word.
      if (word == answer) {
        // return toast.
        setState(() {
          _isCorrect = true;
        });

        ScaffoldMessenger.of(context).showMaterialBanner(
          const MaterialBanner(
            actions: [
              Column(children: [Icon(Icons.check_circle_outline)]),
            ],
            content: Center(
              child: Text(
                'CORRECT!',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print("Incorrect");
        print("rowIndex: $rowIndex");
        setState(() {
          activeRowStartIndex += 5;
          rowIndex += 1;
        });
      }
    }

    //}
  }

  // void generateTextFields() {
  //   var row = List.generate(
  //     5,
  //     (index) => GridItem(
  //       index: index,
  //       isEnabled: _isEnabled,
  //       controller: _controllers[index],
  //     ),
  //   );

  //   setState(() {
  //     _textFields.addAll(row);
  //   });
  // }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        //key: _formKey,
        children: [
          // Form(
          //   key: _formKeysList[0],
          //   child: Column(
          //     children: [
          //       Row(children: _textFields.sublist(0, 5)),
          //       SizedBox(height: 10),
          //     ],
          //   ),
          // ),

          // Form(
          //   key: _formKeysList[1],
          //   child: Column(
          //     children: [
          //       Row(children: _textFields.sublist(5, 10)),
          //       SizedBox(height: 10),
          //     ],
          //   ),
          // ),

          // Form(
          //   key: _formKeysList[2],
          //   child: Column(
          //     children: [
          //       Row(children: _textFields.sublist(10, 15)),
          //       SizedBox(height: 10),
          //     ],
          //   ),
          // ),

          // Form(
          //   key: _formKeysList[3],
          //   child: Column(
          //     children: [
          //       Row(children: _textFields.sublist(15, 20)),
          //       SizedBox(height: 10),
          //     ],
          //   ),
          // ),

          // Form(
          //   key: _formKeysList[4],
          //   child: Column(
          //     children: [
          //       Row(children: _textFields.sublist(20, 25)),
          //       SizedBox(height: 10),
          //     ],
          //   ),
          // ),

          // Form(
          //   key: _formKeysList[5],
          //   child: Column(
          //     children: [
          //       Row(children: _textFields.sublist(25, 30)),
          //       SizedBox(height: 10),
          //     ],
          //   ),
          // ),
          ..._gridForms.values,
          SizedBox(
            height: 45,
            width: 450,
            child: ElevatedButton(
              onPressed: () {
                _isCorrect ? null : onPressed();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                backgroundColor: Colors.green.shade500,
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

/**
 * 
  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(children: _textFields.sublist(0,5)),
            SizedBox(height: 10),
            Row(children: _textFields.sublist(5,10)),
            SizedBox(height: 10),
            Row(children: _textFields.sublist(10,15)),
            SizedBox(height: 10),
            Row(children: _textFields.sublist(15,20)),
            SizedBox(height: 10),
            Row(children: _textFields.sublist(20,25)),
            SizedBox(height: 10),
            Row(children: _textFields.sublist(25,30)),
            SizedBox(height: 10),
            SizedBox(
              height: 45,
              width: 450,
              child: ElevatedButton(
                onPressed: () {
                  _isCorrect ? null : onPressed();
                },
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
 * 
 * 
 * 
 * 
 */