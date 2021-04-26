import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'modules/pages.dart';

const kReleaseMode = false;

void main() {
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
          '/topic_list': (_) => TopicListPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
