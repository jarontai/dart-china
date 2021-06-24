import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_china/features/features.dart';
import 'package:dart_china/models/models.dart';
import 'package:dart_china/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this._userRepository, this._loginBloc, this._registerBloc)
      : super(AppState()) {
    _loginSubscription = _loginBloc.stream.listen((authState) {
      // if (authState is LoginSuccess) {
      //   _updateLogin(true, authState.user);
      //   profileBloc.add(ProfileOpen(username: authState.user.username));
      // } else {
      //   _updateLogin(false, null, notifcation: false);
      // }
    });
    _registerSubscription = _registerBloc.stream.listen((authState) {
      // if (authState is LoginSuccess) {
      //   _updateLogin(true, authState.user);
      //   profileBloc.add(ProfileOpen(username: authState.user.username));
      // } else {
      //   _updateLogin(false, null, notifcation: false);
      // }
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
    if (event is AppOpen) {}
    // if (event is AppLogin) {
    //   emit(state.copyWith(
    //     userLogin: true,
    //     user: event.user,
    //   ));
    // } else if (event is AppLogout) {
    //   emit(state.copyWith(
    //     userLogin: false,
    //     user: null,
    //   ));
    // }
  }

  _checkNotification(String username) async {
    final has = await _userRepository.hasNotification(username);
    emit(state.copyWith(hasNotification: has));
  }
}
