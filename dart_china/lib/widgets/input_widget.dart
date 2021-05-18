import 'package:dart_china/commons.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    Key? key,
    this.hint = '',
    this.label = '',
  }) : super(key: key);

  final String hint;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              hintStyle: TextStyle(color: ColorPalette.postTextColor),
              focusedBorder: OutlineInputBorder(),
              fillColor: ColorPalette.tagColr,
            ),
          ),
        ],
      ),
    );
  }
}
