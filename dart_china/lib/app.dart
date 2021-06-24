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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(
                context.read<AuthRepository>(), context.read<UserRepository>()),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(context.read<UserRepository>(),
                context.read<TopicRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                NotificationCubit(context.read<UserRepository>()),
          ),
          BlocProvider(
            create: (context) => AppCubit(
              BlocProvider.of<LoginBloc>(context),
              BlocProvider.of<ProfileCubit>(context),
              BlocProvider.of<NotificationCubit>(context),
            ),
          ),
          BlocProvider(
            create: (context) => TopicListCubit(context.read<TopicRepository>(),
                context.read<CategoryRepository>()),
          ),
          BlocProvider(
            create: (context) => TopicCubit(context.read<PostRepository>(),
                context.read<TopicRepository>()),
          ),
          BlocProvider(
            create: (context) => SearchBloc(context.read<PostRepository>()),
          ),
          BlocProvider(
            create: (context) => RegisterBloc(context.read<AuthRepository>()),
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
        Routes.search: (_) => SearchPage(),
        Routes.register: (_) => RegisterPage(),
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
