import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_china/repositories/repositories.dart';

import '../../../common.dart';
import '../../../models/models.dart';
import '../../login/cubit/login_cubit.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit(this.loginCubit) : super(GlobalState()) {
    authSubscription = loginCubit.stream.listen((authState) {
      if (authState.isLogin && authState.user != null) {
        _updateLogin(true, authState.user);
      } else {
        _updateLogin(false, null);
      }
    });

    checkLogin();
  }

  final LoginCubit loginCubit;
  StreamSubscription? authSubscription;

  checkLogin() async {
    await loginCubit.check();
  }

  _updateLogin(bool status, User? user) {
    print('App state login change: $status');
    emit(state.copyWith(userLogin: status, user: user));
  }

  @override
  Future<void> close() {
    authSubscription?.cancel();
    return super.close();
  }
}
