import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

class TimeUtil {
  static final DateFormat _formater = DateFormat('yyyy-MM-dd HH:mm:ss');

  static String format(DateTime date) {
    return _formater.format(date);
  }
}
