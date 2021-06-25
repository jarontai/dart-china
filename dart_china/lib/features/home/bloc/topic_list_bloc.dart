import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common.dart';
import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'topic_list_event.dart';
part 'topic_list_state.dart';

const kDefaultCategorySlug = 'all';
const kDefaultCategoryName = '全部';
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
    return super.transformEvents(
        events.debounceTime(Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<TopicListState> mapEventToState(
    TopicListEvent event,
  ) async* {
    if (event is TopicListFetch) {
      _fetchLatest(refresh: event.refresh);
    } else if (event is TopicListPoll) {
      _checkLatest();
    } else if (event is TopicListChangeCategory) {
      _changeCategory(event.categoryIndex);
    }
  }

  Future<List<Category>> _fetchCategories() async {
    var categories = await _categoryRepository.fetchAll();
    categories
        .retainWhere((element) => kEnableCategories.contains(element.slug));
    return categories;
  }

  _fetchLatest({bool refresh = false}) async {
    if (state.status.isInitial) {
      var pageModel = await _topicRepository.fetchLatest();
      var categories = await _fetchCategories();
      categories.insert(0, theAllCategory);
      emit(TopicListState(
        topics: pageModel.data,
        categoryIndex: 0,
        categories: categories,
      ));
    } else if (state.status.isSuccess) {
      if (state.more || refresh) {
        var categoryId;
        var categorySlug;
        var cat = state.categories[state.categoryIndex];
        if (cat.slug != kDefaultCategorySlug) {
          categoryId = cat.id;
          categorySlug = cat.slug;
        }

        emit(state.copyWith(
          paging: true,
        ));
        var nextPage = refresh ? 0 : state.page + 1;
        var pageModel = await _topicRepository.fetchLatest(
            page: nextPage, categoryId: categoryId, categorySlug: categorySlug);
        var oldTopics = refresh ? <Topic>[] : List.of(state.topics);
        emit(state.copyWith(
          topics: oldTopics..addAll(pageModel.data),
          page: nextPage,
          more: pageModel.hasNext,
          paging: false,
        ));
      }
    }
  }

  _checkLatest() async {
    var latest = await _topicRepository.checkLatest();
    if (latest) {
      await _fetchLatest(refresh: true);
    } else {
      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  _changeCategory(int index) async {
    if (state.status.isSuccess) {
      if (index == state.categoryIndex) {
        return;
      }

      var categories = state.categories;
      if (index < categories.length) {
        emit(state.copyWith(
          status: TopicListStatus.loading,
          categoryIndex: index,
        ));
        await _fetchLatest(refresh: true);
      }
    }
  }
}
