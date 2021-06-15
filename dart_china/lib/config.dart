import 'package:flutter/material.dart';

const development = 'development';
const production = 'production';

class AppConfig {
  AppConfig.dev()
      : appName = 'Dart China DEV',
        flavorName = development,
        apiBaseUrl = '',
        siteUrl = 'https://www.dart-china.org',
        cdnUrl = 'https://cdn.dart-china.org';

  AppConfig.prod()
      : appName = 'Dart China',
        flavorName = production,
        apiBaseUrl = '',
        siteUrl = 'https://www.dart-china.org',
        cdnUrl = 'https://cdn.dart-china.org';

  final String appName;
  final String flavorName;
  final String apiBaseUrl;
  final String siteUrl;
  final String? cdnUrl;

  bool get isProd {
    return flavorName == production;
  }

  bool get isDev {
    return flavorName == development;
  }
}

class AppConfigScope extends InheritedWidget {
  AppConfigScope({
    required this.config,
    required Widget child,
  }) : super(child: child);

  final AppConfig config;

  static AppConfigScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfigScope>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
