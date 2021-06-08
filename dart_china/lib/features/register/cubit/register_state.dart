part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterPending extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFail extends RegisterState {}
