import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'login_state.dart';

const _kUsername = 'username';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(LoginState());

  final AuthRepository _authRepository;

  check() async {
    var login = await _authRepository.checkLogin();
    if (login) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var username = prefs.getString(_kUsername);
      if (username != null && username.isNotEmpty) {
        var user = await _authRepository.userInfo(username);
        emit(state.copyWith(
          loading: false,
          isLogin: true,
          user: user,
        ));
      }
    }
  }

  returnRoute(String route) {
    emit(state.copyWith(returnRoute: route));
  }

  login(String username, String password) async {
    emit(state.copyWith(
      loading: true,
      isLogin: false,
      fail: false,
    ));
    var result = await _authRepository.login(username, password);
    result.result((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kUsername, value.username);

      emit(state.copyWith(
        loading: false,
        isLogin: true,
        user: value,
        fail: false,
        errorMessage: '',
      ));
    }, (value) {
      emit(state.copyWith(
        loading: false,
        isLogin: false,
        fail: true,
        errorMessage: '登录失败',
      ));
    });
  }

  logout() async {
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

    emit(state.copyWith(
      isLogin: false,
    ));
  }
}
