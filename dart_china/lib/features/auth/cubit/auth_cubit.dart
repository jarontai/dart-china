import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState());

  final AuthRepository authRepository;

  check() async {
    var login = await authRepository.checkLogin();
    if (login) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var username = prefs.getString('username');
      if (username != null && username.isNotEmpty) {
        var user = await authRepository.userInfo(username);
        emit(state.copyWith(
          loading: false,
          isLogin: true,
          user: user,
        ));
      }
    }
  }

  login(String username, String password) async {
    emit(state.copyWith(
      loading: true,
      isLogin: false,
      user: null,
    ));
    var user = await authRepository.login(username, password);
    emit(state.copyWith(
      loading: false,
      isLogin: true,
      user: user,
    ));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', user.username);
  }

  logout(String username) async {
    await authRepository.logout(username);
    emit(state.copyWith(
      isLogin: false,
      user: null,
    ));
  }
}
