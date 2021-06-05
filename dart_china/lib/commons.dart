import 'dart:async';

import 'package:flutter/material.dart';

const kSplashRadius = 25.0;

abstract class ColorPalette {
  static final backgroundColor = Color(0xFF3978f8);
  static final tagColor = Color(0xFFf2f6fa);
  static final topicBgColor = Color(0xFFF1F6FA);
  static final topicCardColor = Color(0xFFFDFDFD);
  static final titleColor = Colors.black87;
  static final postTextColor = Color(0xFF8E8E9F);
}

abstract class Routes {
  static final home = '/';
  static final topic = '/topic';
  static final search = '/search';
  static final login = '/login';
  static final register = '/register';
}

abstract class RegExps {
  static final username = RegExp(r"^[a-zA-Z0-9]*$");
  static final email = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
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
