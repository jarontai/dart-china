part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterOpen extends RegisterEvent {}

class RegisterPost extends RegisterEvent {
  final String email;
  final String username;
  final String password;

  RegisterPost({
    required this.email,
    required this.username,
    required this.password,
  });
}
