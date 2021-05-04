import 'package:bloc/bloc.dart';
import 'package:dart_china/commons.dart';
import 'package:dart_china/features/features.dart';
import 'package:discourse_api/discourse_api.dart';
import 'package:meta/meta.dart';

import '../../../repositories/repositories.dart';

export 'package:discourse_api/discourse_api.dart' show Topic;

part 'topic_list_state.dart';

class TopicListCubit extends Cubit<TopicListState> {
  TopicListCubit() : super(TopicListInitial());

  TopicRepository get repository => topicRepository;
  final Debouncer _debouncer = Debouncer();

  fetchLatest({bool refresh = false}) async {
    _debouncer.run(() async {
      _doFetchLatest(refresh: refresh);
    });
  }

  _doFetchLatest({bool refresh = false}) async {
    if (state is TopicListInitial || refresh) {
      var topics = await repository.fetchLatest(page: 0);
      emit(TopicListSuccess(topics: topics));
    } else if (state is TopicListSuccess) {
      var previous = state as TopicListSuccess;
      if (previous.more) {
        var currentPage = previous.page + 1;
        var topics = await repository.fetchLatest(page: currentPage);
        emit(previous.copyWith(
          topics: List.of(previous.topics)..addAll(topics),
          page: currentPage,
          more: topics.length > 0,
        ));
      }
    }
  }

  checkLatest() async {
    var latest = await repository.checkLatest();
    if (latest) {
      await fetchLatest(refresh: true);
    } else {
      await Future.delayed(Duration(milliseconds: 500));
    }
  }
}
