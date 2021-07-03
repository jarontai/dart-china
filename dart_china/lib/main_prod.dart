import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:bugly_crash/bugly.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'common.dart';
import 'config.dart';
import 'repositories/repositories.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    print("zone current print error");
    Zone.current.handleUncaughtError(details.exception, details.stack!);
  };

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    EasyLoading.instance..indicatorType = EasyLoadingIndicatorType.fadingCircle;

    Bloc.observer = SimpleBlocObserver();

    await dotenv.load();

    final config = AppConfig.prod();
    await initRepository(config.siteUrl, cdnUrl: config.cdnUrl,
        onClientCreated: (client) {
      getIt.registerSingleton<DiscourseApiClient>(client);
    });
    getIt.registerSingleton<AppConfig>(config);

    runApp(DartChinaApp());
  }, (error, stackTrace) async {
    String type = "flutter uncaught error";
    await Bugly.postException(
        type: type,
        error: error.toString(),
        stackTrace: stackTrace.toString(),
        extraInfo: {});
  });
}
