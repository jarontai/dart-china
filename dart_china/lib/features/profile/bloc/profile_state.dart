part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final User user;
  final List<Topic> recentTopics;

  ProfileSuccess({
    required this.user,
    required this.recentTopics,
  });

  ProfileSuccess copyWith({
    User? user,
    List<Topic>? recentTopics,
  }) {
    return ProfileSuccess(
      user: user ?? this.user,
      recentTopics: recentTopics ?? this.recentTopics,
    );
  }
}
