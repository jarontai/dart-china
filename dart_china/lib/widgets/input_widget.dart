import 'package:dart_china/commons.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    Key? key,
    this.hint = '',
  }) : super(key: key);

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(),
          hintStyle: TextStyle(color: ColorPalette.postTextColor),
          focusedBorder: OutlineInputBorder(),
          fillColor: ColorPalette.tagColr,
        ),
      ),
    );
  }
}
