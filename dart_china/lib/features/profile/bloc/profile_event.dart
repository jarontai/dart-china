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
