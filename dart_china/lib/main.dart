import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'repositories/repositories.dart';

class CubitObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}

setup() async {
  Bloc.observer = CubitObserver();
  await initRepository();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();

  runApp(DartChinaApp());
}
