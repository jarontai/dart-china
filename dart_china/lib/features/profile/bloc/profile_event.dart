part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileInit extends ProfileEvent {
  final String username;

  ProfileInit({
    required this.username,
  });
}

class ProfileUpdateAvatar extends ProfileEvent {
  final int userId;
  final String username;
  final PickedFile newAvatar;

  ProfileUpdateAvatar({
    required this.userId,
    required this.username,
    required this.newAvatar,
  });
}
