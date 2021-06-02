import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';

import 'commons.dart';
import 'features/features.dart';
import 'repositories/repositories.dart';

const kReleaseMode = false;

class DartChinaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(AuthRepository()),
        ),
        BlocProvider(
          create: (context) =>
              GlobalCubit(BlocProvider.of<LoginCubit>(context)),
        ),
        BlocProvider(
          create: (context) =>
              TopicListCubit(TopicRepository(), CategoryRepository()),
        ),
        BlocProvider(
          create: (context) => TopicCubit(PostRepository(), TopicRepository()),
        ),
        BlocProvider(
          create: (context) => SearchCubit(PostRepository()),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
      ],
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (_) => MaterialApp(
          builder: DevicePreview.appBuilder,
          title: 'Dart China',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: Routes.home,
          routes: {
            Routes.home: (_) => HomePage(),
            Routes.login: (_) => LoginPage(),
            Routes.search: (_) => SearchPage(),
            Routes.register: (_) => RegisterPage(),
          },
          onGenerateRoute: (settings) => generateRoutes(settings, context),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }

  // List<BlocProvider> _buildProviders() {
  //   return [
  //     BlocProvider(
  //       create: (context) => LoginCubit(AuthRepository()),
  //     ),
  //     BlocProvider(
  //       create: (context) => GlobalCubit(BlocProvider.of<LoginCubit>(context)),
  //     ),
  //     BlocProvider(
  //       create: (context) =>
  //           TopicListCubit(TopicRepository(), CategoryRepository()),
  //     ),
  //     BlocProvider(
  //       create: (context) => TopicCubit(PostRepository(), TopicRepository()),
  //     ),
  //     BlocProvider(
  //       create: (context) => SearchCubit(PostRepository()),
  //     ),
  //   ];
  // }

  Route<dynamic>? generateRoutes(RouteSettings settings, BuildContext context) {
    var routeName = settings.name;
    if (routeName == Routes.topic) {
      final topicId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => TopicPage(
          topicId: topicId,
        ),
      );
    }
  }
}
