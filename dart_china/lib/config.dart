const development = 'development';
const production = 'production';

class AppConfig {
  AppConfig.dev()
      : appName = 'Dart China DEV',
        flavorName = development,
        apiBaseUrl = '',
        siteUrl = 'https://www.dart-china.org',
        cdnUrl = 'https://cdn.dart-china.org',
        buglyAndroidAppId = '7ba411b3d4',
        buglyIosAppId = '6eb3a75f2a';

  AppConfig.prod()
      : appName = 'Dart China',
        flavorName = production,
        apiBaseUrl = '',
        siteUrl = 'https://www.dart-china.org',
        cdnUrl = 'https://cdn.dart-china.org',
        buglyAndroidAppId = '4d03d3e324',
        buglyIosAppId = '2bc1eb307b';

  final String buglyAndroidAppId;
  final String buglyIosAppId;
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
