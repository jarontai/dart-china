part of 'topic_list_cubit.dart';

@immutable
abstract class TopicListState {}

class TopicListInitial extends TopicListState {}

class TopicListFailure extends TopicListState {}

class TopicListSuccess extends TopicListState {
  final List<Topic> topics;
  final int page;
  final bool more;
  final List<Category> categories;
  final int categoryIndex;
  final bool loading;

  TopicListSuccess({
    required this.topics,
    this.page = 0,
    this.more = true,
    this.categories = const [],
    this.categoryIndex = 0,
    this.loading = false,
  });

  TopicListSuccess copyWith({
    List<Topic>? topics,
    int? page,
    bool? more,
    List<Category>? categories,
    int? categoryIndex,
    bool? loading,
  }) {
    return TopicListSuccess(
      topics: topics ?? this.topics,
      page: page ?? this.page,
      more: more ?? this.more,
      categories: categories ?? this.categories,
      categoryIndex: categoryIndex ?? this.categoryIndex,
      loading: loading ?? this.loading,
    );
  }
}
