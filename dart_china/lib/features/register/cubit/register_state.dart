part of 'register_cubit.dart';

class RegisterState {
  final String initialUrl;
  final String initialData;

  RegisterState({
    this.initialUrl = '',
    this.initialData = '',
  });

  RegisterState copyWith({
    String? initialUrl,
    String? initialData,
  }) {
    return RegisterState(
      initialUrl: initialUrl ?? this.initialUrl,
      initialData: initialData ?? this.initialData,
    );
  }
}
