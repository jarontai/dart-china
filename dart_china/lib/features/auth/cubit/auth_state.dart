part of 'auth_cubit.dart';

class AuthState {
  final bool isLogin;
  final bool loading;
  final User? user;

  AuthState({
    this.isLogin = false,
    this.loading = false,
    this.user,
  });

  AuthState copyWith({
    bool? isLogin,
    bool? loading,
    User? user,
  }) {
    return AuthState(
      isLogin: isLogin ?? this.isLogin,
      loading: loading ?? this.loading,
      user: user ?? this.user,
    );
  }
}
