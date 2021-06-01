part of 'global_cubit.dart';

class GlobalState {
  final bool userLogin;
  final User? user;

  GlobalState({
    this.userLogin = false,
    this.user,
  });

  GlobalState copyWith({
    bool? userLogin,
    User? user,
  }) {
    return GlobalState(
      userLogin: userLogin ?? this.userLogin,
      user: user ?? this.user,
    );
  }
}
