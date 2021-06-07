import 'package:flutter/material.dart';

import '../common.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    this.text = 'Button',
    required this.onPressed,
    this.color,
  }) : super(key: key);

  final Color? color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: OutlinedButton(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: color != null ? color : ColorPalette.backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
