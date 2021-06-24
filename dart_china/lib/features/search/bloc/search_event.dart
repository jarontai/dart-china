part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchOpen extends SearchEvent {}

class SearchFetch extends SearchEvent {
  final String search;
  final bool refresh;

  SearchFetch({
    required this.search,
    this.refresh = false,
  });
}
