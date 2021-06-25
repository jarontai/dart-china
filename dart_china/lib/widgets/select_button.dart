import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {
  const SelectButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.selected = false,
    this.marginRight = 10,
  }) : super(key: key);

  final String text;
  final bool selected;
  final VoidCallback onPressed;
  final double marginRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: marginRight),
      child: TextButton(
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.grey.shade50 : Colors.black45,
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            selected ? Color(0xFF7C7BFC) : Colors.white60,
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.all(0),
          ),
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
