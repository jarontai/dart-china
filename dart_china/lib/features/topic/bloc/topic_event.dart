part of 'topic_bloc.dart';

abstract class TopicEvent extends Equatable {
  const TopicEvent();

  @override
  List<Object> get props => [];
}

class TopicFetch extends TopicEvent {
  final int topicId;
  final bool fetchTopic;

  TopicFetch({
    required this.topicId,
    this.fetchTopic = false,
  });
}

class TopicReply extends TopicEvent {
  final String content;

  TopicReply({
    required this.content,
  });
}
