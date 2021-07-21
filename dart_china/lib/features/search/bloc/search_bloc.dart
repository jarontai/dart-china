import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/models.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._postRepository) : super(SearchState());

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
      yield state.copyWith(status: SearchStatus.initial);
    } else if (event is SearchFetch) {
      if (event.refresh) {
        yield state.copyWith(status: SearchStatus.loading);
      }
      yield await _doSearch(event.search, refresh: event.refresh);
    }
  }

  Future<SearchState> _doSearch(String text, {bool refresh = false}) async {
    var page = 1;
    var oldSlugs = <String>[];
    var oldPosts = <SearchResult>[];

    if (state.hasMore) {
      oldPosts = state.data;
      oldSlugs = state.slugs;
      page = state.page + 1;
    }
    if (refresh) {
      oldPosts = [];
      oldSlugs = [];
      page = 1;
    }

    var pageModel = await _postRepository.search(text, page: page);
    var slugs =
        pageModel.data.map((e) => categorySlugMap[e.topic.categoryId] ?? '');
    return state.copyWith(
      status: SearchStatus.success,
      slugs: List.of(oldSlugs..addAll(slugs)),
      data: List.of(oldPosts..addAll(pageModel.data)),
      hasMore: pageModel.hasNext,
      page: pageModel.page,
    );
  }
}
