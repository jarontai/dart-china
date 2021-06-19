import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_china/features/message/cubit/notification_cubit.dart';
import 'package:dart_china/features/profile/cubit/profile_cubit.dart';

import '../../../models/models.dart';
import '../../login/cubit/login_cubit.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit(this.loginCubit, this.profileCubit, this.notificationCubit)
      : super(GlobalState()) {
    _loginSubscription = loginCubit.stream.listen((authState) {
      if (authState.isLogin && authState.user != null) {
        _updateLogin(true, authState.user);
        profileCubit.init(authState.user!.username);
        _checkNotification(authState.user!.username);
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
  StreamSubscription? _notificationSubscription;

  _checkLogin() async {
    await loginCubit.check();
  }

  _updateLogin(bool status, User? user, {bool? notifcation}) {
    print('App state login change: $status');
    emit(state.copyWith(
        userLogin: status, user: user, hasNotification: notifcation));
  }

  _checkNotification(String username) async {
    final has = await notificationCubit.hasNotification(username);
    emit(state.copyWith(hasNotification: has));
  }

  @override
  Future<void> close() {
    _loginSubscription?.cancel();
    _notificationSubscription?.cancel();
    return super.close();
  }
}
