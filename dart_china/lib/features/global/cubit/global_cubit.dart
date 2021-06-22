import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../models/models.dart';
import '../../login/cubit/login_cubit.dart';
import '../../message/cubit/notification_cubit.dart';
import '../../profile/cubit/profile_cubit.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit(this.loginCubit, this.profileCubit, this.notificationCubit)
      : super(GlobalState()) {
    _loginSubscription = loginCubit.stream.listen((authState) {
      if (authState.isLogin && authState.user != null) {
        _updateLogin(true, authState.user);
        profileCubit.init(authState.user!.username);
      } else {
        _updateLogin(false, null, notifcation: false);
      }
    });

    _checkLogin();
  }

  final NotificationCubit notificationCubit;
  final LoginCubit loginCubit;
  final ProfileCubit profileCubit;
  StreamSubscription? _loginSubscription;

  _checkLogin() async {
    await loginCubit.check();
  }

  _updateLogin(bool status, User? user, {bool? notifcation}) {
    print('App state login change: $status');
    emit(state.copyWith(
        userLogin: status, user: user, hasNotification: notifcation));
  }

  checkNotification([String? username]) async {
    if (username != null || state.user != null) {
      final has = await notificationCubit
          .hasNotification(username ?? state.user!.username);
      emit(state.copyWith(hasNotification: has));
    }
  }

  @override
  Future<void> close() {
    _loginSubscription?.cancel();
    return super.close();
  }
}
