import 'package:flutter/material.dart';

class StatusBanner extends MaterialBanner {
  StatusBanner({super.key, required bool success, required String text})
    : super(
        actions: [
          Column(children: success ? [Icon(Icons.check_circle_outline)] : []),
        ],
        content: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        backgroundColor: success ? Colors.green : Colors.red,
      );
}
