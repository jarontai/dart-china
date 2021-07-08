part of 'profile_bloc.dart';

enum ProfileStateStatus {
  initial,
  loading,
  success,
  updating,
  updatingSuccess,
  failure
}

extension ProfileStateStatusX on ProfileStateStatus {
  bool get isInitial => this == ProfileStateStatus.initial;
  bool get isLoading => this == ProfileStateStatus.loading;
  bool get isSuccess => this == ProfileStateStatus.success;
  bool get isUpdating => this == ProfileStateStatus.updating;
  bool get isUpdatingSuccess => this == ProfileStateStatus.updatingSuccess;
  bool get isFailure => this == ProfileStateStatus.failure;
}

class ProfileState extends Equatable {
  final ProfileStateStatus status;
  final User? user;
  final List<Topic> recentTopics;

  ProfileState({
    this.status = ProfileStateStatus.initial,
    this.user,
    this.recentTopics = const [],
  });

  @override
  List<Object?> get props => [status, user, recentTopics];

  ProfileState copyWith({
    ProfileStateStatus? status,
    User? user,
    List<Topic>? recentTopics,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      recentTopics: recentTopics ?? this.recentTopics,
    );
  }
}
