import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'commons.dart';
import 'features/features.dart';

const kReleaseMode = false;

class DartChinaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<AppCubit>()..checkLogin(),
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (_) => MaterialApp(
          builder: DevicePreview.appBuilder,
          title: 'Dart China',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: TopicListPage.routeName,
          onGenerateRoute: (settings) => generateRoutes(settings, context),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }

  Route<dynamic>? generateRoutes(RouteSettings settings, BuildContext context) {
    var routeName = settings.name;
    if (routeName == TopicListPage.routeName) {
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt.get<TopicListCubit>()..fetchLatest(),
          child: TopicListPage(),
        ),
      );
    } else if (routeName == TopicPage.routeName) {
      final topic = settings.arguments as Topic;
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt.get<TopicCubit>()..fetchTopic(topic),
          child: TopicPage(
            topic: topic,
          ),
        ),
      );
    } else if (routeName == LoginPage.routeName) {
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => getIt.get<AuthCubit>(),
          child: LoginPage(),
        ),
      );
    }
  }
}
