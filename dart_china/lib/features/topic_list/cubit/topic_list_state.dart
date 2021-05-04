part of 'topic_list_cubit.dart';

@immutable
abstract class TopicListState {}

class TopicListInitial extends TopicListState {}

class TopicListFailure extends TopicListState {}

class TopicListSuccess extends TopicListState {
  final List<Topic> topics;
  final int page;
  final bool more;
  final Map<String, String> categories;
  final String category;

  TopicListSuccess({
    required this.topics,
    this.page = 0,
    this.more = true,
    this.categories = const {'all': 'all'},
    this.category = 'all',
  });

  TopicListSuccess copyWith({
    List<Topic>? topics,
    int? page,
    bool? more,
    Map<String, String>? categories,
    String? category,
  }) {
    return TopicListSuccess(
      topics: topics ?? this.topics,
      page: page ?? this.page,
      more: more ?? this.more,
      categories: categories ?? this.categories,
      category: category ?? this.category,
    );
  }
}
