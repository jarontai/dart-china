part of 'topic_list_bloc.dart';

abstract class TopicListEvent extends Equatable {
  const TopicListEvent();

  @override
  List<Object?> get props => [];
}

class TopicListInit extends TopicListEvent {}

class TopicListFetch extends TopicListEvent {
  final bool refresh;
  final int? categoryIndex;

  TopicListFetch({
    this.refresh = false,
    this.categoryIndex,
  });

  @override
  List<Object?> get props => [refresh, categoryIndex];
}

class TopicListPoll extends TopicListEvent {}

class TopicListChangeCategory extends TopicListEvent {
  final int categoryIndex;

  TopicListChangeCategory({
    required this.categoryIndex,
  });

  @override
  List<Object?> get props => [categoryIndex];
}
