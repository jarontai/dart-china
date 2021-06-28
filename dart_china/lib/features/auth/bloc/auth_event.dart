part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginOpen extends AuthEvent {
  final String returnRoute;

  AuthLoginOpen({
    this.returnRoute = '/',
  });
}

class AuthLoginPost extends AuthEvent {
  final String username;
  final String password;

  AuthLoginPost({
    required this.username,
    required this.password,
  });
}

class AuthLoginCheck extends AuthEvent {}

class AuthLogout extends AuthEvent {}
