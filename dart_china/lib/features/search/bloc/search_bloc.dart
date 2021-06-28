import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/models.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._postRepository) : super(SearchInitial());

  final PostRepository _postRepository;

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      Stream<SearchEvent> events,
      TransitionFunction<SearchEvent, SearchState> transitionFn) {
    return super.transformEvents(
        events.debounceTime(Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchInit) {
      emit(SearchInitial());
    } else if (event is SearchFetch) {
      _doSearch(event.search, refresh: event.refresh);
    }
  }

  void _doSearch(String text, {bool refresh = false}) async {
    if (refresh) {
      emit(SearchInitial());
    }

    var page = 1;
    var oldSlugs = <String>[];
    var oldPosts = <SearchResult>[];
    var theState = state;
    if (theState is SearchInitial) {
      emit(SearchLoading());
    } else if (theState is SearchSuccess) {
      if (!theState.more || theState.paging) {
        return;
      }
      emit(theState.copyWith(loading: true));

      oldPosts = theState.data;
      oldSlugs = theState.slugs;
      page = theState.page + 1;
    }

    var pageModel = await _postRepository.search(text, page: page);
    var slugs =
        pageModel.data.map((e) => categorySlugMap[e.topic.categoryId] ?? '');
    emit(SearchSuccess(
      slugs: List.of(oldSlugs..addAll(slugs)),
      data: List.of(oldPosts..addAll(pageModel.data)),
      more: pageModel.hasNext,
      page: pageModel.page,
      paging: false,
    ));
  }
}
