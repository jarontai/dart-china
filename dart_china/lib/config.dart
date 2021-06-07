import 'package:flutter/material.dart';

const development = 'development';
const production = 'production';

class Config {
  Config.dev()
      : appName = 'Dart China DEV',
        flavorName = development,
        apiBaseUrl = '',
        siteUrl = 'https://www.dart-china.org',
        cdnUrl = 'https://cdn.dart-china.org';

  Config.prod()
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

  bool get isProduction {
    return flavorName == production;
  }

  bool get isDevelopment {
    return flavorName == development;
  }
}

class ConfigWidget extends InheritedWidget {
  ConfigWidget({
    required this.config,
    required Widget child,
  }) : super(child: child);

  final Config config;

  static ConfigWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ConfigWidget>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
