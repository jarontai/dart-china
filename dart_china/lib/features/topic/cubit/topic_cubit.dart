import 'package:bloc/bloc.dart';
import 'package:discourse_api/discourse_api.dart';

import '../../../commons.dart';
import '../../../repositories/repositories.dart';

part 'topic_state.dart';

class TopicCubit extends Cubit<TopicState> {
  TopicCubit() : super(TopicState(init: true));

  PostRepository get repository => thePostRepository;
  TopicRepository get topicRepository => theTopicRepository;

  final Debouncer _debouncer = Debouncer();

  fetchTopic(int topicId) async {
    var topic = await topicRepository.findTopic(topicId);
    emit(state.copyWith(
      init: false,
      topic: topic,
    ));
  }

  fetchTopicPosts({int page = 1}) async {
    if (state.topic != null && state.more && page > 0) {
      _debouncer.run(() async {
        await _doFetchTopicPosts(page: page);
      });
    }
  }

  _doFetchTopicPosts({int page = 1}) async {
    if (state.topic != null) {
      var posts = await repository.fetchTopicPosts(state.topic!);
      var more = posts.length > 0;
      emit(state.copyWith(
        init: false,
        posts: List.of(state.posts)..addAll(posts),
        more: more,
      ));
    }
  }
}
