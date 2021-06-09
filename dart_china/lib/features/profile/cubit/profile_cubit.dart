import 'package:bloc/bloc.dart';
import 'package:dart_china/repositories/repositories.dart';
import 'package:image_picker/image_picker.dart';
import 'package:result_type/result_type.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.authRepository) : super(ProfileInitial());

  final AuthRepository authRepository;

  updateAvatar(int userId, String username, PickedFile file) async {
    final bytes = await file.readAsBytes();
    final uploadId = await authRepository.uploadAvatar(userId, bytes);
    if (uploadId != null && uploadId > 0) {
      await authRepository.updateAvatar(username, uploadId);
    }
  }
}
