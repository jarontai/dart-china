part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState({this.returnRoute});

  final String? returnRoute;

  @override
  List<Object> get props => [];
}

class AuthLoginInitial extends AuthState {}

class AuthLoginPending extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final User user;

  AuthLoginSuccess({
    required this.user,
  });

  AuthLoginSuccess copyWith({
    User? user,
  }) {
    return AuthLoginSuccess(
      user: user ?? this.user,
    );
  }
}

class AuthLoginFail extends AuthState {
  final String error;

  AuthLoginFail({
    required this.error,
  });
}

class AuthLogoutSuccess extends AuthState {}
