import 'dart:async';

import 'package:flutter/material.dart';

typedef IndexCallback = void Function(int index);
typedef StrDataCallback = void Function(String data);

const kBackgroundColor = Color(0xFF2656cc);
const kTagColr = Color(0xFFf2f6fa);

const kSplashRadius = 25.0;

// const kMainGradient = LinearGradient(
//   colors: [
//     Color(0xFF435AE4),
//     Color(0xFF4162D2),
//   ],
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   // stops: [0.1, 0.8],
// );

class Debouncer {
  late int millisecond;
  Timer? _timer;

  Debouncer({this.millisecond = 300});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: millisecond), action);
  }
}
