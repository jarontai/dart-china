part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchOpen extends SearchEvent {}

class SearchSearch extends SearchEvent {
  final String search;
  final bool refresh;

  SearchSearch({
    required this.search,
    this.refresh = false,
  });
}
