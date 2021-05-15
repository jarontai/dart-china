import 'package:bloc/bloc.dart';
import 'package:discourse_api/discourse_api.dart';
import 'package:meta/meta.dart';

import '../../../commons.dart';
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
const kEnableCategories = ['share', 'question', 'meta'];

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
    if (state is TopicListInitial) {
      var topics = await topicRepository.fetchLatest(page: 0);
      var categories = await _fetchCategories();
      categories.insert(0, theAllCategory);
      emit(TopicListSuccess(
        topics: topics,
        categoryIndex: 0,
        categories: categories,
        loading: false,
      ));
    } else if (state is TopicListSuccess) {
      var current = state as TopicListSuccess;
      if (current.more || refresh) {
        var categoryId;
        var categorySlug;
        var cat = current.categories[current.categoryIndex];
        if (cat.slug != kDefaultCategorySlug) {
          categoryId = cat.id;
          categorySlug = cat.slug;
        }

        var nextPage = refresh ? 0 : current.page + 1;
        var newTopics = await topicRepository.fetchLatest(
            page: nextPage, categoryId: categoryId, categorySlug: categorySlug);

        var oldTopics = refresh ? <Topic>[] : List.of(current.topics);
        emit(current.copyWith(
          topics: oldTopics..addAll(newTopics),
          page: nextPage,
          more: newTopics.length > 0,
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
    if (state is TopicListSuccess) {
      var current = state as TopicListSuccess;
      if (index == current.categoryIndex) {
        return;
      }

      var categories = current.categories;
      if (index < categories.length) {
        emit(current.copyWith(
          categoryIndex: index,
          loading: true,
        ));
        await fetchLatest(refresh: true);
      }
    }
  }
}
