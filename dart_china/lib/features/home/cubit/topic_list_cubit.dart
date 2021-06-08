import 'package:bloc/bloc.dart';
import 'package:discourse_api/discourse_api.dart';
import 'package:meta/meta.dart';

import '../../../common.dart';
import '../../../repositories/repositories.dart';
import '../../features.dart';

export 'package:discourse_api/discourse_api.dart' show Topic;

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

class TopicListCubit extends Cubit<TopicListState> {
  TopicListCubit(
    this.topicRepository,
    this.categoryRepository,
  ) : super(TopicListInitial());

  final TopicRepository topicRepository;
  final CategoryRepository categoryRepository;
  final Debouncer _debouncer = Debouncer();

  fetchLatest({bool refresh = false}) async {
    _debouncer.run(() async {
      _doFetchLatest(refresh: refresh);
    });
  }

  Future<List<Category>> _fetchCategories() async {
    var categories = await categoryRepository.fetchAll();
    categories
        .retainWhere((element) => kEnableCategories.contains(element.slug));
    return categories;
  }

  _doFetchLatest({bool refresh = false}) async {
    var myState = state;
    if (myState is TopicListInitial) {
      var pageModel = await topicRepository.fetchLatest();
      var categories = await _fetchCategories();
      categories.insert(0, theAllCategory);
      emit(TopicListSuccess(
        topics: pageModel.data,
        categoryIndex: 0,
        categories: categories,
        loading: false,
      ));
    } else if (myState is TopicListSuccess) {
      if (myState.more || refresh) {
        var categoryId;
        var categorySlug;
        var cat = myState.categories[myState.categoryIndex];
        if (cat.slug != kDefaultCategorySlug) {
          categoryId = cat.id;
          categorySlug = cat.slug;
        }

        var nextPage = refresh ? 0 : myState.page + 1;
        var pageModel = await topicRepository.fetchLatest(
            page: nextPage, categoryId: categoryId, categorySlug: categorySlug);

        var oldTopics = refresh ? <Topic>[] : List.of(myState.topics);
        emit(myState.copyWith(
          topics: oldTopics..addAll(pageModel.data),
          page: nextPage,
          more: pageModel.hasNext,
          loading: false,
        ));
      }
    }
  }

  checkLatest() async {
    var latest = await topicRepository.checkLatest();
    if (latest) {
      await fetchLatest(refresh: true);
    } else {
      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  changeCategory(int index) async {
    var myState = state;
    if (myState is TopicListSuccess) {
      if (index == myState.categoryIndex) {
        return;
      }

      var categories = myState.categories;
      if (index < categories.length) {
        emit(myState.copyWith(
          categoryIndex: index,
          loading: true,
        ));
        await fetchLatest(refresh: true);
      }
    }
  }
}
