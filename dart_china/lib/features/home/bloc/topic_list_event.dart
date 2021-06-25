part of 'topic_list_bloc.dart';

abstract class TopicListEvent extends Equatable {
  const TopicListEvent();

  @override
  List<Object> get props => [];
}

class TopicListInit extends TopicListEvent {}

class TopicListFetch extends TopicListEvent {
  final bool refresh;

  TopicListFetch({
    this.refresh = false,
  });
}

class TopicListPoll extends TopicListEvent {}

class TopicListChangeCategory extends TopicListEvent {
  final int categoryIndex;

  TopicListChangeCategory({
    required this.categoryIndex,
  });
}
