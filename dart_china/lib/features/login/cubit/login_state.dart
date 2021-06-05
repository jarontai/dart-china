part of 'login_cubit.dart';

class LoginState {
  final bool isLogin;
  final bool loading;
  final User? user;
  final String? returnRoute;
  final bool fail;
  final String message;

  LoginState({
    this.isLogin = false,
    this.loading = false,
    this.user,
    this.returnRoute,
    this.fail = false,
    this.message = '',
  });

  LoginState copyWith({
    bool? isLogin,
    bool? loading,
    User? user,
    String? returnRoute,
    bool? fail,
    String? message,
  }) {
    return LoginState(
      isLogin: isLogin ?? this.isLogin,
      loading: loading ?? this.loading,
      user: user ?? this.user,
      returnRoute: returnRoute ?? this.returnRoute,
      fail: fail ?? this.fail,
      message: message ?? this.message,
    );
  }
}
