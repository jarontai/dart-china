import 'package:flutter_dotenv/flutter_dotenv.dart';

const development = 'development';
const production = 'production';

class AppConfig {
  AppConfig.dev()
      : appName = 'Dart China DEV',
        flavorName = development,
        apiBaseUrl = '',
        siteUrl = dotenv.env['DEV_SITE_URL']!,
        cdnUrl = dotenv.env['DEV_CDN_URL']!,
        buglyAndroidAppId = dotenv.env['DEV_BUGLY_ANDROID_APP_ID']!,
        buglyIosAppId = dotenv.env['DEV_BUGLY_IOS_APP_ID']!;

  AppConfig.prod()
      : appName = 'Dart China',
        flavorName = production,
        apiBaseUrl = '',
        siteUrl = dotenv.env['PROD_SITE_URL']!,
        cdnUrl = dotenv.env['PROD_CDN_URL']!,
        buglyAndroidAppId = dotenv.env['PROD_BUGLY_ANDROID_APP_ID']!,
        buglyIosAppId = dotenv.env['PROD_BUGLY_IOS_APP_ID']!;

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
