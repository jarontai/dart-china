import 'package:bloc/bloc.dart';
import '../../../repositories/repositories.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(RegisterState());

  final AuthRepository _authRepository;

  Future<void> prepare() async {
    var list = await _authRepository.githubAuthData();
    assert(list.length == 2);
    emit(state.copyWith(
      initialUrl: list[0],
      initialData: list[1],
    ));
  }
}
