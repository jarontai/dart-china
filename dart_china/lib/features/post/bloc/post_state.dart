part of 'post_bloc.dart';

enum PostStatus {
  initial,
  loading,
  loadSuccess,
  submitting,
  submitSuccess,
  failure
}

extension PostStatusX on PostStatus {
  bool get isInitial => this == PostStatus.initial;
  bool get isLoading => this == PostStatus.loading;
  bool get isLoadingSuccess => this == PostStatus.loadSuccess;
  bool get isSubmitting => this == PostStatus.submitting;
  bool get isSubmitSuccess => this == PostStatus.submitSuccess;
  bool get isFailure => this == PostStatus.failure;
}

class PostState extends Equatable {
  final PostStatus status;
  final Topic? topic;

  PostState({
    this.status = PostStatus.initial,
    this.topic,
  });

  @override
  List<Object?> get props => [status, topic];

  PostState copyWith({
    PostStatus? status,
    Topic? topic,
  }) {
    return PostState(
      status: status ?? this.status,
      topic: topic ?? this.topic,
    );
  }
}
