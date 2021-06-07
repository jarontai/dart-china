import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  Bloc.observer = CubitObserver();

  final config = Config.dev();
  await initRepository(config.siteUrl, cdnUrl: config.cdnUrl);

  runApp(ConfigWidget(config: config, child: DartChinaApp()));
}
