part of 'app_cubit.dart';

class AppState {
  final bool userLogin;
  final User? user;

  AppState({
    this.userLogin = false,
    this.user,
  });

  AppState copyWith({
    bool? userLogin,
    User? user,
  }) {
    return AppState(
      userLogin: userLogin ?? this.userLogin,
      user: user ?? this.user,
    );
  }
}
