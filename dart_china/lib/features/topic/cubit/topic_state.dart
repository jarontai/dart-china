part of 'topic_cubit.dart';

enum TopicStatus { initial, success, posting }

class TopicState {
  final TopicStatus status;
  final Topic? topic;
  final List<Post> posts;
  final int page;
  final bool more;
  final bool loading;
  final bool enableReply;
  final bool postSuccess;

  TopicState({
    this.status = TopicStatus.initial,
    this.topic,
    this.posts = const [],
    this.page = 0,
    this.more = true,
    this.loading = false,
    this.enableReply = false,
    this.postSuccess = false,
  });

  TopicState copyWith({
    TopicStatus? status,
    Topic? topic,
    List<Post>? posts,
    int? page,
    bool? more,
    bool? loading,
    bool? enableReply,
    bool? postSuccess,
  }) {
    return TopicState(
      status: status ?? this.status,
      topic: topic ?? this.topic,
      posts: posts ?? this.posts,
      page: page ?? this.page,
      more: more ?? this.more,
      loading: loading ?? this.loading,
      enableReply: enableReply ?? this.enableReply,
      postSuccess: postSuccess ?? this.postSuccess,
    );
  }
}
