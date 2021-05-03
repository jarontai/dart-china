import 'package:bloc/bloc.dart';
import 'package:dart_china/commons.dart';
import 'package:dart_china/features/features.dart';
import 'package:discourse_api/discourse_api.dart';
import 'package:meta/meta.dart';

import '../../../repositories/repositories.dart';

export 'package:discourse_api/discourse_api.dart' show Topic;

part 'topic_state.dart';

class TopicCubit extends Cubit<TopicState> {
  final TopicRepository repository = TopicRepository();
  final Debouncer _debouncer = Debouncer();

  TopicCubit() : super(TopicInitial());

  Future<void> fetchLatest({bool refresh = false}) async {
    _debouncer.run(() async {
      _doFetchLatest(refresh: refresh);
    });
  }

  Future<void> _doFetchLatest({bool refresh = false}) async {
    if (state is TopicInitial || refresh) {
      var topics = await repository.latestTopics(page: 0);
      emit(TopicSuccess(topics: topics));
    } else if (state is TopicSuccess) {
      var previous = state as TopicSuccess;
      if (previous.more) {
        var currentPage = previous.page + 1;
        var topics = await repository.latestTopics(page: currentPage);
        var current = previous.copyWith(
          topics: List.of(previous.topics)..addAll(topics),
          page: currentPage,
          more: topics.length > 0,
        );
        emit(current);
      }
    }
  }

  Future<void> pollLatest() async {
    var latest = await repository.hasNewTopic();
    if (latest) {
      await fetchLatest(refresh: true);
    }
  }
}
