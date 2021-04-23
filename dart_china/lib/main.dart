import 'package:flutter/material.dart';

import 'package:dart_china/modules/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
