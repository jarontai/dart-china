import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.pressed,
  }) : super(key: key);

  final String text;
  final bool pressed;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFFb8bbc5),
        ),
      ),
      style: ButtonStyle(),
      onPressed: () {},
    );
  }
}
