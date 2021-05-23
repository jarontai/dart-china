import 'dart:async';

import 'package:flutter/material.dart';

typedef DataCallback<T> = void Function(T data);

const kSplashRadius = 25.0;

abstract class ColorPalette {
  static final backgroundColor = Color(0xFF3978f8);
  static final tagColr = Color(0xFFf2f6fa);
  static final topicBgColor = Color(0xFFF1F6FA);
  static final topicCardColor = Color(0xFFFDFDFD);
  static final titleColor = Colors.black87;
  static final postTextColor = Color(0xFF8E8E9F);
}

class Debouncer {
  late int millisecond;
  Timer? _timer;

  Debouncer({this.millisecond = 500});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: millisecond), action);
  }
}
