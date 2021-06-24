part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterOpen extends RegisterEvent {}

class RegisterRegister extends RegisterEvent {
  final String email;
  final String username;
  final String password;

  RegisterRegister({
    required this.email,
    required this.username,
    required this.password,
  });
}
