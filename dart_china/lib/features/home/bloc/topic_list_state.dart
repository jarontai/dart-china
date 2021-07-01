part of 'topic_list_bloc.dart';

enum TopicListStatus { initial, loading, success, failure }

extension TopicListStatusX on TopicListStatus {
  bool get isInitial => this == TopicListStatus.initial;
  bool get isLoading => this == TopicListStatus.loading;
  bool get isSuccess => this == TopicListStatus.success;
  bool get isFailure => this == TopicListStatus.failure;
}

class TopicListState extends Equatable {
  final TopicListStatus status;
  final List<Topic> topics;
  final int page;
  final bool hasMore;
  final List<Category> categories;
  final int categoryIndex;

  TopicListState({
    this.status = TopicListStatus.initial,
    this.topics = const [],
    this.page = -1,
    this.hasMore = true,
    this.categories = const [],
    this.categoryIndex = 0,
  });

  TopicListState copyWith({
    TopicListStatus? status,
    List<Topic>? topics,
    int? page,
    bool? hasMore,
    List<Category>? categories,
    int? categoryIndex,
  }) {
    return TopicListState(
      status: status ?? this.status,
      topics: topics ?? this.topics,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      categories: categories ?? this.categories,
      categoryIndex: categoryIndex ?? this.categoryIndex,
    );
  }

  @override
  List<Object?> get props =>
      [status, topics, page, hasMore, categories, categoryIndex];

  @override
  bool? get stringify => false;

  @override
  String toString() {
    return '$runtimeType($status)';
  }
}
