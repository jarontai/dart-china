import 'package:dart_china/repositories/repositories.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/features.dart';

const kReleaseMode = true;
// final topicCubit = TopicListCubit()..fetchLatest();

class DartChinaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: !kReleaseMode,
      builder: (_) => MaterialApp(
        builder: DevicePreview.appBuilder,
        title: 'Dart China',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/topic_list',
        routes: {
          TopicListPage.routeName: (_) {
            return BlocProvider(
              create: (context) => TopicListCubit(
                context.read<TopicRepository>(),
                context.read<CategoryRepository>(),
              )..fetchLatest(),
              child: TopicListPage(),
            );
          },
        },
        onGenerateRoute: (settings) {
          if (settings.name == TopicPage.routeName) {
            final topic = settings.arguments as Topic;
            return MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => TopicCubit(
                  context.read<PostRepository>(),
                  context.read<TopicRepository>(),
                ),
                child: TopicPage(
                  topic: topic,
                ),
              ),
            );
          }
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
