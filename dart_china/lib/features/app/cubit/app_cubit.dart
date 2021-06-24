import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';
import '../../login/bloc/login_bloc.dart';
import '../../message/cubit/notification_cubit.dart';
import '../../profile/cubit/profile_cubit.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this.loginBloc, this.profileCubit, this.notificationCubit)
      : super(AppState()) {
    _loginSubscription = loginBloc.stream.listen((authState) {
      if (authState is LoginSuccess) {
        _updateLogin(true, authState.user);
        profileCubit.init(authState.user.username);
      } else {
        _updateLogin(false, null, notifcation: false);
      }
    });

    _checkLogin();
  }

  final NotificationCubit notificationCubit;
  final LoginBloc loginBloc;
  final ProfileCubit profileCubit;
  StreamSubscription? _loginSubscription;

  _checkLogin() {
    loginBloc.add(LoginCheck());
  }

  _updateLogin(bool status, User? user, {bool? notifcation}) {
    // print('App state login change: $status');
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
