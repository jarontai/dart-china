import 'package:flutter/material.dart';

import 'package:dart_china/constants.dart';
import 'package:dart_china/modules/pages.dart';

void main() {
  runApp(DartChinaApp());
}

class DartChinaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dart China',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/topic_list',
      routes: {
        '/topic_list': (_) => TopicListPage(),
      },
    );
  }
}
