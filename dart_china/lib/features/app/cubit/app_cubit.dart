import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../models/models.dart';
import '../../login/cubit/login_cubit.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final LoginCubit loginCubit;
  StreamSubscription? authSubscription;

  AppCubit(this.loginCubit) : super(AppState()) {
    authSubscription = loginCubit.stream.listen((authState) {
      if (authState.isLogin && authState.user != null) {
        updateLogin(true, authState.user);
      } else {
        updateLogin(false, null);
      }
    });

    checkLogin();
  }

  checkLogin() async {
    await loginCubit.check();
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
