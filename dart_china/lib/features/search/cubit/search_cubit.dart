import 'package:bloc/bloc.dart';
import 'package:discourse_api/discourse_api.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/repositories.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(
    this._postRepository,
  ) : super(SearchInitial());

  final PostRepository _postRepository;

  void init() {
    emit(SearchInitial());
  }

  void search(String data, {bool refresh = false}) async {
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
      oldPosts = theState.data;
      oldSlugs = theState.slugs;
      page = theState.page + 1;
      emit(theState.copyWith(loading: true));
    }

    var pageModel = await _postRepository.search(data, page: page);
    var slugs =
        pageModel.data.map((e) => categorySlugMap[e.topic.categoryId] ?? '');
    emit(SearchSuccess(
      slugs: oldSlugs..addAll(slugs),
      data: oldPosts..addAll(pageModel.data),
      more: pageModel.hasNext,
      page: pageModel.page,
      loading: false,
    ));
  }
}
