import 'package:bloc/bloc.dart';
import 'package:dart_china/models/models.dart';
import 'package:dart_china/repositories/repositories.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState());

  final AuthRepository authRepository;

  login(String username, String password) async {
    emit(state.copyWith(
      loading: true,
      isLogin: false,
      user: null,
    ));
    var user = await authRepository.login(username, password);
    emit(state.copyWith(
      loading: false,
      isLogin: true,
      user: user,
    ));
  }

  logout(String username) async {
    await authRepository.logout(username);
    emit(state.copyWith(
      isLogin: false,
      user: null,
    ));
  }
}
