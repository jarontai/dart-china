import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'repositories/repositories.dart';

class CubitObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}

setup() async {
  Bloc.observer = CubitObserver();

  await initRepository();

  // Register repositories and cubits
  // getIt.registerSingleton<TopicRepository>(TopicRepository());
  // getIt.registerSingleton<PostRepository>(PostRepository());
  // getIt.registerSingleton<CategoryRepository>(CategoryRepository());
  // getIt.registerSingleton<AuthRepository>(AuthRepository());

  // getIt.registerFactory(() => TopicListCubit(
  //     getIt.get<TopicRepository>(), getIt.get<CategoryRepository>()));
  // getIt.registerFactory(() =>
  //     TopicCubit(getIt.get<PostRepository>(), getIt.get<TopicRepository>()));
  // getIt.registerFactory(() => AuthCubit(getIt.get<AuthRepository>()));
  // getIt.registerFactory(() => AppCubit(getIt.get<AuthCubit>()));
}

void main() async {
  await setup();

  runApp(DartChinaApp());
}
