part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterPending extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFail extends RegisterState {}
