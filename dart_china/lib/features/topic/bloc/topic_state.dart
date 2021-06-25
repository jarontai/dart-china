part of 'topic_bloc.dart';

enum TopicStatus { initial, loading, success, paging, posting, failure }

extension TopicStatusX on TopicStatus {
  bool get isInitial => this == TopicStatus.initial;
  bool get isLoading => this == TopicStatus.loading;
  bool get isSuccess => this == TopicStatus.success;
  bool get isPaging => this == TopicStatus.paging;
  bool get isPosting => this == TopicStatus.posting;
  bool get isFailure => this == TopicStatus.failure;
}

class TopicState extends Equatable {
  final TopicStatus status;
  final Topic? topic;
  final List<Post> posts;
  final int page;
  final bool more;
  final bool paging;
  final bool postSuccess;

  TopicState({
    this.status = TopicStatus.initial,
    this.topic,
    this.posts = const [],
    this.page = -1,
    this.more = true,
    this.paging = false,
    this.postSuccess = false,
  });

  TopicState copyWith({
    TopicStatus? status,
    Topic? topic,
    List<Post>? posts,
    int? page,
    bool? more,
    bool? paging,
    bool? postSuccess,
  }) {
    return TopicState(
      status: status ?? this.status,
      topic: topic ?? this.topic,
      posts: posts ?? this.posts,
      page: page ?? this.page,
      more: more ?? this.more,
      paging: paging ?? this.paging,
      postSuccess: postSuccess ?? this.postSuccess,
    );
  }

  @override
  List<Object?> get props => [status, topic, posts, page, paging, postSuccess];
}
