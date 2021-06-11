part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final User user;
  final List<Topic> recentTopics;

  ProfileSuccess({
    required this.user,
    required this.recentTopics,
  });
}
