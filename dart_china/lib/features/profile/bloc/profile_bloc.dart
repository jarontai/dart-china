import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.authRepository, this.topicRepository)
      : super(ProfileState());

  final UserRepository authRepository;
  final TopicRepository topicRepository;

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileInit) {
      yield state.copyWith(status: ProfileStateStatus.loading);
      yield await _init(event.username);
    } else if (event is ProfileUpdateAvatar) {
      yield state.copyWith(status: ProfileStateStatus.updating);
      await _updateAvatar(event.userId, event.username, event.newAvatar);
      this.add(ProfileInit(username: event.username));
    }
  }

  Future<ProfileState> _init(String username) async {
    final user = await authRepository.userProfile(username);
    final topics = await topicRepository.recentReadTopics();
    return state.copyWith(
        status: ProfileStateStatus.success, user: user, recentTopics: topics);
  }

  _updateAvatar(int userId, String username, PickedFile file) async {
    final bytes = await file.readAsBytes();
    final uploadId = await authRepository.uploadAvatar(userId, bytes);
    if (uploadId != null && uploadId > 0) {
      await authRepository.updateAvatar(username, uploadId);
    }
  }

  // updateBio(String username, String bio) async {
  //   await authRepository.updateBio(username, bio);
  //   init(username);
  // }
}
