import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

const _kUsername = 'username';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository, this._userRepository)
      : super(AuthLoginInitial());

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthLoginOpen) {
      emit(AuthLoginInitial());
    } else if (event is AuthLoginPost) {
      _login(event.username, event.password);
    } else if (event is AuthLogout) {
      _logout();
    } else if (event is AuthLoginCheck) {
      _check();
    }
  }

  _check() async {
    var login = await _authRepository.checkLogin();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString(_kUsername);
    if (login) {
      if (username != null && username.isNotEmpty) {
        var user = await _userRepository.userInfo(username);
        emit(AuthLoginSuccess(user: user));
      }
    } else {
      if (username != null) {
        await _authRepository.logout(username);
      }
    }
  }

  _login(String username, String password) async {
    emit(AuthLoginPending());
    var result = await _authRepository.login(username, password);
    result.result((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kUsername, value.username);

      emit(AuthLoginSuccess(user: value));
    }, (value) {
      emit(AuthLoginFail(error: '登录失败'));
    });
  }

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString(_kUsername);
    if (username != null) {
      await _authRepository.logout(username);
    }
    prefs.remove(_kUsername);

    var dir = await getApplicationDocumentsDirectory();
    var folder = Directory(dir.path + '/.cookies');
    var list = folder.listSync();
    for (var item in list) {
      await item.delete(recursive: true);
    }

    emit(AuthLogoutSuccess());
  }
}
