part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState({this.returnRoute});

  final String? returnRoute;

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginPending extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess({
    required this.user,
  });

  LoginSuccess copyWith({
    User? user,
  }) {
    return LoginSuccess(
      user: user ?? this.user,
    );
  }
}

class LoginFail extends LoginState {
  final String error;

  LoginFail({
    required this.error,
  });
}

class LoginLogoutSuccess extends LoginState {}
