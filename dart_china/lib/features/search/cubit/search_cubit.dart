import 'package:bloc/bloc.dart';
import 'package:dart_china/repositories/repositories.dart';
import 'package:discourse_api/discourse_api.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(
    this._postRepository,
  ) : super(SearchInitial());

  final PostRepository _postRepository;

  void search(String data, {bool refresh = false}) async {
    var page = 1;
    var oldPosts = <SearchResult>[];
    var currentState = state;
    if (!refresh && currentState is SearchSuccess) {
      oldPosts = currentState.data;
      page = currentState.page + 1;
    }

    emit(SearchLoading(data: oldPosts));
    var pageModel = await _postRepository.search(data, page: page);
    emit(SearchSuccess(
      data: oldPosts..addAll(pageModel.data),
      more: pageModel.hasNext,
      page: pageModel.page,
    ));
  }
}
