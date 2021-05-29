import 'package:flutter/material.dart';

import '../commons.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    Key? key,
    this.controller,
    this.validator,
    this.hint = '',
    this.label = '',
    this.obscure = false,
    this.inputAction,
    this.prefix,
    this.onSubmit,
  }) : super(key: key);

  final String hint;
  final String label;
  final bool obscure;
  final ValueChanged<String>? onSubmit;
  final Widget? prefix;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputAction? inputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onFieldSubmitted: onSubmit,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: inputAction,
            controller: controller,
            validator: validator,
            obscureText: obscure,
            style: TextStyle(),
            decoration: InputDecoration(
              prefixIcon: prefix,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 0,
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
                borderSide: BorderSide(
                  color: Colors.blue.shade400,
                  width: 1,
                ),
              ),
              fillColor: ColorPalette.tagColor,
              filled: true,
            ),
          ),
        ],
      ),
    );
  }
}
