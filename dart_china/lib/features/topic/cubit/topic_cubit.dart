import 'package:bloc/bloc.dart';
import 'package:discourse_api/discourse_api.dart';

import '../../../commons.dart';
import '../../../repositories/repositories.dart';

export 'package:discourse_api/discourse_api.dart' show Topic, Post, User;

part 'topic_state.dart';

class TopicCubit extends Cubit<TopicState> {
  TopicCubit() : super(TopicState());

  PostRepository get repository => thePostRepository;
  TopicRepository get topicRepository => theTopicRepository;

  final Debouncer _debouncer = Debouncer();

  fetchTopic(Topic topic) async {
    var theTopic = await topicRepository.findTopic(topic.id);
    theTopic = theTopic.copyWith(
      poster: topic.poster,
    );
    emit(state.copyWith(
      status: TopicStatus.success,
      topic: theTopic,
      posts: List.of(theTopic.posts ?? []),
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
        posts: state.posts..addAll(posts),
        more: more,
      ));
    }
  }
}
