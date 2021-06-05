import 'package:bloc/bloc.dart';

import '../../../repositories/repositories.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(RegisterInitial());

  final AuthRepository _authRepository;

  Future<bool> isAvailable({String? email, String? username}) async {
    var result1 = true;
    var result2 = true;
    if (email != null) {
      result1 = await _authRepository.checkEmail(email);
    }
    if (username != null) {
      result2 = await _authRepository.checkUsername(username);
    }
    return result1 && result2;
  }

  Future<void> register(String email, String username, String password) async {
    emit(RegisterPending());
    final result = await _authRepository.register(email, username, password);
    if (result) {
      emit(RegisterSuccess());
    } else {
      emit(RegisterFail());
    }
  }
}
