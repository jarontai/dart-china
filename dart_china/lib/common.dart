import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

export './config.dart';

late Logger logger;

final getIt = GetIt.instance;

const kSplashRadius = 25.0;

const kDefaultPostType = 1;
const kEnableCategories = ['share', 'question', 'meta'];
const kDefaultCategorySlug = 'all';
const kDefaultCategoryName = '全部';
const kCategoryNameMap = {
  'share': '分享',
  'question': '问答',
  'meta': '站务',
  'all': '全部',
};

const CategoryColorMap = {
  'share': Color(0xFF3AB54A),
  'question': Color(0xFFF1592A),
  'meta': Color(0xFF888281),
};

abstract class Messages {
  static final loginSuccess = '登录成功';
  static final registerSuccess = '注册成功';
  static final registerFail = '注册失败';
  static final logoutSuccess = '登出成功';
}

abstract class ColorPalette {
  static final backgroundColor = Color(0xFF3978f8);
  static final homeBackgroundColor = Color(0xFF4162D2);
  static final tagColor = Color(0xFFf2f6fa);
  static final topicBgColor = Color(0xFFF1F6FA);
  static final topicCardColor = Color(0xFFFDFDFD);
  static final titleColor = Colors.black87;
  static final postTextColor = Color(0xFF8E8E9F);
}

abstract class Routes {
  static const home = '/';
  static const topic = '/topic';
  static const search = '/search';
  static const login = '/login';
  static const register = '/register';
  static const profile = '/profile';
  static const notification = '/notification';
  static const post = '/post';
  static const tos = '/tos';
  static const privacy = '/privacy';
  static const about = '/about';

  static const loginRoutes = const [profile, notification, post];
}

abstract class RegExps {
  static final username = RegExp(r"^[a-zA-Z0-9]*$");
  static final email = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
}
