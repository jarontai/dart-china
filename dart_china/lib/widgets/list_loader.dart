import 'package:flutter/material.dart';

class ListLoader extends StatelessWidget {
  const ListLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      alignment: Alignment.center,
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
