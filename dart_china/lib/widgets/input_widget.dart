import 'package:flutter/material.dart';

import '../commons.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    Key? key,
    this.hint = '',
    this.label = '',
    this.obscure = false,
  }) : super(key: key);

  final String hint;
  final String label;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            child: TextField(
              obscureText: obscure,
              style: TextStyle(),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: hint,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15),
                ),
                hintStyle: TextStyle(color: ColorPalette.postTextColor),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: Colors.blue.shade400, width: 1)),
                fillColor: ColorPalette.tagColr,
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
