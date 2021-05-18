import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_china/features/auth/cubit/auth_cubit.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthCubit authCubit;
  StreamSubscription? authSubscription;

  AppCubit(this.authCubit) : super(AppState()) {
    authSubscription = authCubit.stream.listen((authState) {
      if (authState.isLogin && authState.user != null) {
        updateLoginStatus(true);
      } else {
        updateLoginStatus(false);
      }
    });
  }

  updateLoginStatus(bool status) {
    print('App state login change: $status');
    emit(state.copyWith(userLogin: status));
  }

  @override
  Future<void> close() {
    authSubscription?.cancel();
    return super.close();
  }
}
