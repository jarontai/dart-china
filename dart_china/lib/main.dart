import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repositories/repositories.dart';
import 'features/features.dart';

const kReleaseMode = false;
final topicCubit = TopicCubit()..fetchLatest();

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

class DartChinaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      builder: (_) => MaterialApp(
        builder: DevicePreview.appBuilder,
        title: 'Dart China',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/topic_list',
        routes: {
          '/topic_list': (_) {
            return BlocProvider(
              create: (_) => topicCubit,
              child: TopicListPage(),
            );
          },
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
