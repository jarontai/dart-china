part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  final List<SearchResult> data;

  SearchLoading({
    required this.data,
  });

  SearchLoading copyWith({
    List<SearchResult>? data,
  }) {
    return SearchLoading(
      data: data ?? this.data,
    );
  }
}

class SearchSuccess extends SearchState {
  final List<SearchResult> data;
  final int page;
  final bool more;

  SearchSuccess({
    required this.data,
    required this.page,
    required this.more,
  });

  SearchSuccess copyWith({
    List<SearchResult>? data,
    int? page,
    bool? more,
  }) {
    return SearchSuccess(
      data: data ?? this.data,
      page: page ?? this.page,
      more: more ?? this.more,
    );
  }
}
