import 'package:bloc/bloc.dart';
import 'package:discourse_api/discourse_api.dart';

import '../../../repositories/repositories.dart';
import '../../../util.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(
    this._postRepository,
  ) : super(SearchInitial());

  final PostRepository _postRepository;
  final Debouncer _debouncer = Debouncer();

  void init() {
    emit(SearchInitial());
  }

  void search(String text, {bool refresh = false}) async {
    _debouncer.run(() async {
      _doSearch(text, refresh: refresh);
    });
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
      if (!theState.more || theState.loading) {
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
      loading: false,
    ));
  }
}
