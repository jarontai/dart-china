part of 'app_cubit.dart';

class AppState {
  final bool userLogin;

  AppState({
    this.userLogin = false,
  });

  AppState copyWith({
    bool? userLogin,
  }) {
    return AppState(
      userLogin: userLogin ?? this.userLogin,
    );
  }
}
