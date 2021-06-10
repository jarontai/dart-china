import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'config.dart';
import 'common.dart';
import 'features/features.dart';
import 'repositories/repositories.dart';

class DartChinaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isProduction = AppConfigScope.of(context).config.isProduction;

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
          create: (context) => RegisterCubit(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(AuthRepository()),
        ),
      ],
      child: isProduction
          ? Builder(builder: (context) {
              return _buildApp(context, true);
            })
          : DevicePreview(
              builder: (context) {
                return _buildApp(context, false);
              },
            ),
    );
  }

  Widget _buildApp(BuildContext context, bool production) {
    return MaterialApp(
      builder: EasyLoading.init(builder: (context, child) {
        if (!production) {
          child = DevicePreview.appBuilder(context, child);
        }
        return child!;
      }),
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
      onGenerateRoute: (settings) => _generateRoutes(settings, context),
      debugShowCheckedModeBanner: false,
    );
  }

  Route<dynamic>? _generateRoutes(
      RouteSettings settings, BuildContext context) {
    var routeName = settings.name;
    if (routeName == Routes.topic) {
      final topicId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => TopicPage(
          topicId: topicId,
        ),
      );
    } else if (routeName == Routes.profile) {
      var username;
      if (settings.arguments != null) {
        username = settings.arguments as String;
      }
      return MaterialPageRoute(
        builder: (_) => ProfilePage(
          username: username,
        ),
      );
    }
  }
}
