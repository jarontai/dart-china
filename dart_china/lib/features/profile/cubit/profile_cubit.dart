import 'package:bloc/bloc.dart';
import 'package:dart_china/models/models.dart';
import 'package:dart_china/repositories/repositories.dart';
import 'package:image_picker/image_picker.dart';
import 'package:result_type/result_type.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.authRepository, this.topicRepository)
      : super(ProfileInitial());

  final AuthRepository authRepository;
  final TopicRepository topicRepository;

  init(String username) async {
    final user = await authRepository.userProfile(username);
    final topics = await topicRepository.recentReadTopics();
    emit(ProfileSuccess(user: user, recentTopics: topics));
    // emit(ProfileSuccess(user: user, recentTopics: []));
  }

  updateAvatar(int userId, String username, PickedFile file) async {
    final bytes = await file.readAsBytes();
    final uploadId = await authRepository.uploadAvatar(userId, bytes);
    if (uploadId != null && uploadId > 0) {
      await authRepository.updateAvatar(username, uploadId);
    }
    init(username);
  }

  updateBio(String username, String bio) async {
    await authRepository.updateBio(username, bio);
    init(username);
  }
}
