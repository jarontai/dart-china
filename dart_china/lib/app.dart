import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'common.dart';
import 'config.dart';
import 'features/features.dart';
import 'repositories/repositories.dart';

class DartChinaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isProd = AppConfigScope.of(context).config.isProd;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),
        RepositoryProvider<UserRepository>(create: (_) => UserRepository()),
        RepositoryProvider<TopicRepository>(create: (_) => TopicRepository()),
        RepositoryProvider<CategoryRepository>(
            create: (_) => CategoryRepository()),
        RepositoryProvider<PostRepository>(create: (_) => PostRepository()),
      ],
      // Global blocs
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(
                context.read<AuthRepository>(), context.read<UserRepository>()),
          ),
          BlocProvider(
            create: (context) => RegisterBloc(context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => AppBloc(context.read<UserRepository>(),
                context.read<LoginBloc>(), context.read<RegisterBloc>())
              ..add(AppOpen()),
          ),
        ],
        child: isProd
            ? Builder(builder: (context) {
                return _buildApp(context, true);
              })
            : DevicePreview(
                builder: (context) {
                  return _buildApp(context, false);
                },
              ),
      ),
    );
  }

  Widget _buildApp(BuildContext context, bool isProd) {
    return MaterialApp(
      builder: EasyLoading.init(builder: (context, child) {
        if (!isProd) {
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
        Routes.register: (_) => RegisterPage(),
        Routes.search: (context) => BlocProvider<SearchBloc>(
              create: (context) => SearchBloc(
                context.read<PostRepository>(),
              ),
              child: SearchPage(),
            ),
        Routes.notification: (_) => NotificationPage(),
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
        builder: (_) => BlocProvider<TopicBloc>(
          create: (context) => TopicBloc(
            context.read<TopicRepository>(),
            context.read<PostRepository>(),
          ),
          child: TopicPage(
            topicId: topicId,
          ),
        ),
      );
    } else if (routeName == Routes.profile) {
      var username;
      if (settings.arguments != null) {
        username = settings.arguments as String;
      }
      return MaterialPageRoute(
        builder: (_) => BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
            context.read<UserRepository>(),
            context.read<TopicRepository>(),
          ),
          child: ProfilePage(
            username: username,
          ),
        ),
      );
    }
  }
}
