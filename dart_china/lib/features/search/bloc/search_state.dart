part of 'search_bloc.dart';

enum SearchStatus { initial, loading, success, failure }

extension SearchStatusX on SearchStatus {
  bool get isInitial => this == SearchStatus.initial;
  bool get isLoading => this == SearchStatus.loading;
  bool get isSuccess => this == SearchStatus.success;
  bool get isFailure => this == SearchStatus.failure;
}

class SearchState extends Equatable {
  final SearchStatus status;
  final List<String> slugs;
  final List<SearchResult> data;
  final int page;
  final bool hasMore;

  SearchState({
    this.status = SearchStatus.initial,
    this.slugs = const [],
    this.data = const [],
    this.page = 0,
    this.hasMore = true,
  });

  SearchState copyWith({
    SearchStatus? status,
    List<String>? slugs,
    List<SearchResult>? data,
    int? page,
    bool? hasMore,
  }) {
    return SearchState(
      status: status ?? this.status,
      slugs: slugs ?? this.slugs,
      data: data ?? this.data,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object> get props => [status, slugs, data, page, hasMore];
}
