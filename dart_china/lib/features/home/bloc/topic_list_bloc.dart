import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common.dart';
import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'topic_list_event.dart';
part 'topic_list_state.dart';

final theAllCategory = Category(
  id: 0,
  color: '',
  slug: kDefaultCategorySlug,
  name: kDefaultCategoryName,
  topicCount: 0,
  description: 'all',
);

class TopicListBloc extends Bloc<TopicListEvent, TopicListState> {
  TopicListBloc(this._categoryRepository, this._topicRepository)
      : super(TopicListState());

  final CategoryRepository _categoryRepository;
  final TopicRepository _topicRepository;

  @override
  Stream<Transition<TopicListEvent, TopicListState>> transformEvents(
      Stream<TopicListEvent> events,
      TransitionFunction<TopicListEvent, TopicListState> transitionFn) {
    final nonDebounce = events.where((event) => event is! TopicListFetch);
    final debounce = events
        .where((event) => event is TopicListFetch)
        .debounceTime(Duration(milliseconds: 500));
    return super
        .transformEvents(MergeStream([nonDebounce, debounce]), transitionFn);
  }

  @override
  Stream<TopicListState> mapEventToState(
    TopicListEvent event,
  ) async* {
    if (event is TopicListInit) {
      yield await _fetchCategories();
    } else if (event is TopicListFetch) {
      if (event.refresh) {
        yield state.copyWith(
          status: TopicListStatus.loading,
          categoryIndex: event.categoryIndex ?? state.categoryIndex,
        );
      }

      yield await _fetchLatest(
          refresh: event.refresh, categoryIndex: event.categoryIndex);
    } else if (event is TopicListPoll) {
      var latest = await _topicRepository.checkLatest();
      if (latest) {
        yield await _fetchLatest(refresh: true);
      }
    } else if (event is TopicListChangeCategory) {
      if (event.categoryIndex == state.categoryIndex) {
        return;
      }

      yield state.copyWith(categoryIndex: event.categoryIndex);

      var categories = state.categories;
      if (event.categoryIndex < categories.length) {
        this.add(
          TopicListFetch(refresh: true, categoryIndex: event.categoryIndex),
        );
      }
    }
  }

  Future<TopicListState> _fetchCategories() async {
    var categories = await _categoryRepository.fetchAll();
    categories
        .retainWhere((element) => kEnableCategories.contains(element.slug));
    categories.insert(0, theAllCategory);
    return state.copyWith(
      categoryIndex: 0,
      categories: categories,
    );
  }

  Future<TopicListState> _fetchLatest(
      {bool refresh = false, int? categoryIndex}) async {
    if (state.hasMore || refresh) {
      var categoryId;
      var categorySlug;
      var newCategoryIndex = categoryIndex ?? state.categoryIndex;
      var cat = state.categories[newCategoryIndex];
      if (cat.slug != kDefaultCategorySlug) {
        categoryId = cat.id;
        categorySlug = cat.slug;
      }

      var nextPage = refresh ? 0 : state.page + 1;
      var pageModel = await _topicRepository.fetchLatest(
          page: nextPage, categoryId: categoryId, categorySlug: categorySlug);
      var oldTopics = refresh ? <Topic>[] : List.of(state.topics);
      return state.copyWith(
        status: TopicListStatus.success,
        topics: oldTopics..addAll(pageModel.data),
        page: nextPage,
        hasMore: pageModel.hasNext,
        categoryIndex: newCategoryIndex,
      );
    }

    return state;
  }
}
