part of 'topic_list_bloc.dart';

abstract class TopicListEvent extends Equatable {
  const TopicListEvent();

  @override
  List<Object> get props => [];
}

class TopicListFetch extends TopicListEvent {
  final bool refresh;

  TopicListFetch({
    required this.refresh,
  });
}

class TopicListPoll extends TopicListEvent {}

class TopicListChangeCategory extends TopicListEvent {}
