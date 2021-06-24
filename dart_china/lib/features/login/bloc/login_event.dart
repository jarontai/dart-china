part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginOpen extends LoginEvent {
  final String returnRoute;

  LoginOpen({
    this.returnRoute = '/',
  });
}

class LoginLogin extends LoginEvent {
  final String username;
  final String password;

  LoginLogin({
    required this.username,
    required this.password,
  });
}

class LoginCheck extends LoginEvent {}

class LoginLogout extends LoginEvent {}
