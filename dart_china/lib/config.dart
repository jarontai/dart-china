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
        jpushAppkey = dotenv.env['DEV_JPUSH_APPKEY']!,
        buglyAndroidAppId = dotenv.env['DEV_BUGLY_ANDROID_APP_ID']!,
        buglyIosAppId = dotenv.env['DEV_BUGLY_IOS_APP_ID']!,
        enablePreview = false,
        enalbeBugly = false,
        enalbeBuglyDebug = false;

  AppConfig.prod()
      : appName = 'Dart China',
        flavorName = production,
        apiBaseUrl = '',
        siteUrl = dotenv.env['PROD_SITE_URL']!,
        cdnUrl = dotenv.env['PROD_CDN_URL']!,
        jpushAppkey = dotenv.env['PROD_JPUSH_APPKEY']!,
        buglyAndroidAppId = dotenv.env['PROD_BUGLY_ANDROID_APP_ID']!,
        buglyIosAppId = dotenv.env['PROD_BUGLY_IOS_APP_ID']!,
        enablePreview = false,
        enalbeBugly = true,
        enalbeBuglyDebug = false;

  final String jpushAppkey;
  final bool enablePreview;
  final bool enalbeBugly;
  final bool enalbeBuglyDebug;
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
