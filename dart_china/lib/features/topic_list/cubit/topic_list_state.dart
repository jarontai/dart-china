part of 'topic_list_cubit.dart';

@immutable
abstract class TopicListState {}

class TopicListInitial extends TopicListState {}

class TopicListFailure extends TopicListState {}

class TopicListSuccess extends TopicListState {
  final List<Topic> topics;
  final int page;
  final bool more;

  TopicListSuccess({required this.topics, this.page = 0, this.more = true});

  TopicListSuccess copyWith({
    List<Topic>? topics,
    int? page,
    bool? more,
  }) {
    return TopicListSuccess(
      topics: topics ?? this.topics,
      page: page ?? this.page,
      more: more ?? this.more,
    );
  }
}
