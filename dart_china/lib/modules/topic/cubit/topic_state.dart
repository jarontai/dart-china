part of 'topic_cubit.dart';

@immutable
abstract class TopicState {}

class TopicInitial extends TopicState {}

class TopicFailure extends TopicState {}

class TopicSuccess extends TopicState {
  final List<Topic> topics;

  TopicSuccess(this.topics);
}
