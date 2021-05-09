part of 'topic_cubit.dart';

enum TopicStatus { initial, success }

class TopicState {
  final TopicStatus status;
  final bool error;
  final String? errorMessage;
  final Topic? topic;
  final List<Post> posts;
  final int page;
  final bool more;

  TopicState({
    this.status = TopicStatus.initial,
    this.error = false,
    this.errorMessage,
    this.topic,
    this.posts = const [],
    this.page = 0,
    this.more = true,
  });

  TopicState copyWith({
    TopicStatus? status,
    bool? error,
    String? errorMessage,
    Topic? topic,
    List<Post>? posts,
    int? page,
    bool? more,
  }) {
    return TopicState(
      status: status ?? this.status,
      error: error ?? this.error,
      errorMessage: errorMessage ?? this.errorMessage,
      topic: topic ?? this.topic,
      posts: posts ?? this.posts,
      page: page ?? this.page,
      more: more ?? this.more,
    );
  }
}
