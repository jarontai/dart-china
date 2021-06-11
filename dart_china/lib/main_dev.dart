import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'app.dart';
import 'config.dart';
import 'repositories/repositories.dart';

class CubitObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  EasyLoading.instance..indicatorType = EasyLoadingIndicatorType.ring;

  Bloc.observer = CubitObserver();

  final config = AppConfig.dev();
  await initRepository(config.siteUrl, cdnUrl: config.cdnUrl);

  runApp(AppConfigScope(
    config: config,
    child: DartChinaApp(),
  ));
}
