import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../models/models.dart';
import '../../auth/cubit/auth_cubit.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthCubit authCubit;
  StreamSubscription? authSubscription;

  AppCubit(this.authCubit) : super(AppState()) {
    authSubscription = authCubit.stream.listen((authState) {
      if (authState.isLogin && authState.user != null) {
        updateLogin(true, authState.user);
      } else {
        updateLogin(false, null);
      }
    });

    checkLogin();
  }

  checkLogin() async {
    await authCubit.check();
  }

  updateLogin(bool status, User? user) {
    print('App state login change: $status');
    emit(state.copyWith(userLogin: status, user: user));
  }

  @override
  Future<void> close() {
    authSubscription?.cancel();
    return super.close();
  }
}
