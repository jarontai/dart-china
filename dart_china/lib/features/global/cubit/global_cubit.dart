import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../models/models.dart';
import '../../auth/cubit/login_cubit.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  final LoginCubit loginCubit;
  StreamSubscription? authSubscription;

  GlobalCubit(this.loginCubit) : super(GlobalState()) {
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
