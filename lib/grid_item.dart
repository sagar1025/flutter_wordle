import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GridItem extends StatefulWidget {
  final int index;
  final bool isEnabled;
  final TextEditingController controller;
  final Color filledColor;
  const GridItem({
    required this.index,
    required this.isEnabled,
    required this.controller,
    required this.filledColor,
    super.key,
  });

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  final GlobalKey<FormFieldState> _itemKey = GlobalKey<FormFieldState>();
  final FocusNode currentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    currentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        margin: const EdgeInsets.only(right: 15),
        child: Center(
          child: TextFormField(
            key: _itemKey,
            enabled: widget.isEnabled,
            style: TextStyle(
              fontSize: 26,
              color: !widget.isEnabled ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
            focusNode: currentFocusNode,
            autofocus: widget.index % 5 == 0,
            onChanged: (value) {
              if (value.isNotEmpty) {
                currentFocusNode.nextFocus();
              }
            },
            controller: widget.controller,
            textInputAction:
                (widget.index + 1) % 5 == 0
                    ? TextInputAction.done
                    : TextInputAction.next,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
              TextInputFormatter.withFunction((oldValue, newValue) {
                return TextEditingValue(text: newValue.text.toUpperCase());
              }),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: Platform.isIOS ? const EdgeInsets.fromLTRB(18, 12, 16, 12) : const EdgeInsets.fromLTRB(20, 12, 16, 12),
              errorStyle: TextStyle(color: Colors.transparent, fontSize: 0),
              fillColor: !widget.isEnabled ? widget.filledColor : Colors.grey,
              filled: !widget.isEnabled && widget.controller.text.isNotEmpty,
            ),
          ),
        ),
      ),
    );
  }
}
