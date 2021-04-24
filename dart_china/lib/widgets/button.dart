import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.selected,
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
            color: selected ? Color(0xFF4F6ED5) : Color(0xFFB2B3BF),
          ),
        ),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              selected ? Color(0xFFD6E0F4) : Colors.grey.shade300,
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(0),
            )),
        onPressed: onPressed,
      ),
    );
  }
}
