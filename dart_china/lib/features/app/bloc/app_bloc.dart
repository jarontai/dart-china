import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../features.dart';
import '../../../models/models.dart';
import '../../../repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this._userRepository, this._loginBloc, this._registerBloc)
      : super(AppState()) {
    _loginSubscription = _loginBloc.stream.listen((authState) {
      if (authState is LoginSuccess) {
        _updateLogin(true, authState.user);
      }
    });
    _registerSubscription = _registerBloc.stream.listen((authState) {
      if (authState is RegisterSuccess) {
        _updateLogin(true, authState.user);
      }
    });
  }

  final UserRepository _userRepository;
  final LoginBloc _loginBloc;
  final RegisterBloc _registerBloc;
  late StreamSubscription _loginSubscription;
  late StreamSubscription _registerSubscription;

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AppOpen) {
      if (state.userLogin) {
        _checkNotification(state.user!.username);
      }
    } else if (event is AppHome) {
      // if (state.userLogin) {
      //   _checkNotification(state.user!.username);
      // }
    }
  }

  _updateLogin(bool status, User? user, {bool? notifcation}) {
    emit(state.copyWith(
        userLogin: status, user: user, hasNotification: notifcation));
  }

  _checkNotification(String username) async {
    final has = await _userRepository.hasNotification(username);
    emit(state.copyWith(hasNotification: has));
  }

  @override
  Future<void> close() {
    _loginSubscription.cancel();
    _registerSubscription.cancel();
    return super.close();
  }
}
