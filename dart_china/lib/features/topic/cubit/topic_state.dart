part of 'topic_cubit.dart';

@immutable
abstract class TopicState {}

class TopicInitial extends TopicState {}

class TopicFailure extends TopicState {}

class TopicSuccess extends TopicState {
  final List<Topic> topics;
  final int page;
  final bool more;

  TopicSuccess({required this.topics, this.page = 0, this.more = true});

  TopicSuccess copyWith({
    List<Topic>? topics,
    int? page,
    bool? more,
  }) {
    return TopicSuccess(
      topics: topics ?? this.topics,
      page: page ?? this.page,
      more: more ?? this.more,
    );
  }
}
