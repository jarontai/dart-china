import 'dart:async';

import 'package:flutter/material.dart';

const kSplashRadius = 25.0;
const kEnableCategories = ['share', 'question', 'meta'];

const CategoryNameMap = {
  'share': '分享',
  'question': '问答',
  'meta': '站务',
  'all': '全部',
};

const CategoryColorMap = {
  'share': Color(0xFF40a37e),
  'question': Color(0xFFd9a01c),
  'meta': Color(0xFFa19b8f),
};

abstract class Messages {
  static final loginSuccess = '登录成功！';
}

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
  static final profile = '/profile';
  static final message = '/message';
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
