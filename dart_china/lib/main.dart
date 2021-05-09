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

void main() async {
  Bloc.observer = CubitObserver();

  await initRepository();

  runApp(DartChinaApp());
}
