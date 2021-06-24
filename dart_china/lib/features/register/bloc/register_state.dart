part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterPending extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final User user;

  RegisterSuccess({
    required this.user,
  });

  RegisterSuccess copyWith({
    User? user,
  }) {
    return RegisterSuccess(
      user: user ?? this.user,
    );
  }
}

class RegisterFailure extends RegisterState {}
