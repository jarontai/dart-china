part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<SearchResult> data;
  final int page;
  final bool more;
  final bool loading;

  SearchSuccess({
    required this.data,
    required this.page,
    required this.more,
    this.loading = false,
  });

  SearchSuccess copyWith({
    List<SearchResult>? data,
    int? page,
    bool? more,
    bool? loading,
  }) {
    return SearchSuccess(
      data: data ?? this.data,
      page: page ?? this.page,
      more: more ?? this.more,
      loading: loading ?? this.loading,
    );
  }
}
