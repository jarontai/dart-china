import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'login_event.dart';
part 'login_state.dart';

const _kUsername = 'username';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authRepository, this._userRepository) : super(LoginInitial());

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginOpen) {
      emit(LoginInitial());
    } else if (event is LoginPost) {
      _login(event.username, event.password);
    } else if (event is LoginLogout) {
      _logout();
    } else if (event is LoginCheck) {
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
        emit(LoginSuccess(user: user));
      }
    } else {
      if (username != null) {
        await _authRepository.logout(username);
      }
    }
  }

  _login(String username, String password) async {
    emit(LoginPending());
    var result = await _authRepository.login(username, password);
    result.result((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kUsername, value.username);

      emit(LoginSuccess(user: value));
    }, (value) {
      emit(LoginFail(error: '登录失败'));
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

    emit(LoginLogoutSuccess());
  }
}
