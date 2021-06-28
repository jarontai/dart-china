import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.authRepository, this.topicRepository)
      : super(ProfileInitial());

  final UserRepository authRepository;
  final TopicRepository topicRepository;

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileInit) {
      _init(event.username);
    }
  }

  _init(String username) async {
    final user = await authRepository.userProfile(username);
    final topics = await topicRepository.recentReadTopics();
    emit(ProfileSuccess(user: user, recentTopics: topics));
  }

  // updateAvatar(int userId, String username, PickedFile file) async {
  //   final bytes = await file.readAsBytes();
  //   final uploadId = await authRepository.uploadAvatar(userId, bytes);
  //   if (uploadId != null && uploadId > 0) {
  //     await authRepository.updateAvatar(username, uploadId);
  //   }
  //   init(username);
  // }

  // updateBio(String username, String bio) async {
  //   await authRepository.updateBio(username, bio);
  //   init(username);
  // }
}
