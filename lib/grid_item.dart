import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GridItem extends StatefulWidget {
  final int index;
  final bool isEnabled;
  final TextEditingController controller;
  const GridItem({
    required this.index,
    required this.isEnabled,
    required this.controller,
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
        padding: const EdgeInsets.all(5),
        child: TextFormField(
          key: _itemKey,
          enabled: widget.isEnabled,
          style: const TextStyle(fontSize: 26),
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
            border: OutlineInputBorder(borderRadius: BorderRadius.zero),
            contentPadding: const EdgeInsets.fromLTRB(24, 12, 2, 18),
            errorStyle: TextStyle(color: Colors.transparent, fontSize: 0),
          ),
        ),
      ),
    );
  }
}
