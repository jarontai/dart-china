part of 'topic_cubit.dart';

class TopicState {
  final bool init;
  final bool error;
  final String? errorMessage;
  final Topic? topic;
  final List<Post> posts;
  final int page;
  final bool more;

  TopicState({
    this.init = false,
    this.error = false,
    this.errorMessage,
    this.topic,
    this.posts = const [],
    this.page = 0,
    this.more = true,
  });

  TopicState copyWith({
    bool? init,
    bool? error,
    String? errorMessage,
    Topic? topic,
    List<Post>? posts,
    int? page,
    bool? more,
  }) {
    return TopicState(
      init: init ?? this.init,
      error: error ?? this.error,
      errorMessage: errorMessage ?? this.errorMessage,
      topic: topic ?? this.topic,
      posts: posts ?? this.posts,
      page: page ?? this.page,
      more: more ?? this.more,
    );
  }
}
