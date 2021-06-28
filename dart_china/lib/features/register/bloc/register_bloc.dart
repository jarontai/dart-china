import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._authRepository) : super(RegisterInitial());

  final AuthRepository _authRepository;

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterInit) {
      emit(RegisterInitial());
    } else if (event is RegisterPost) {
      _register(event.email, event.username, event.password);
    }
  }

  Future<void> _register(String email, String username, String password) async {
    emit(RegisterPending());
    final result = await _authRepository.register(email, username, password);
    if (result) {
      final user = await _authRepository.login(username, password);
      user.result((value) {
        emit(RegisterSuccess(user: value));
      }, (value) {
        emit(RegisterFailure());
      });
    } else {
      emit(RegisterFailure());
    }
  }

  Future<bool> checkAvailable({String? email, String? username}) async {
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
}
