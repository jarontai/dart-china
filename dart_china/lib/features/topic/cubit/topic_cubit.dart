import 'package:bloc/bloc.dart';
import 'package:discourse_api/discourse_api.dart';

import '../../../commons.dart';
import '../../../repositories/repositories.dart';

export 'package:discourse_api/discourse_api.dart' show Topic, Post, User;

part 'topic_state.dart';

class TopicCubit extends Cubit<TopicState> {
  TopicCubit(
    this.postRepository,
    this.topicRepository,
  ) : super(TopicState());

  final PostRepository postRepository;
  final TopicRepository topicRepository;

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

  fetchTopicPosts() async {
    if (state.topic != null && state.more) {
      _debouncer.run(() async {
        await _doFetchTopicPosts();
      });
    }
  }

  _doFetchTopicPosts() async {
    if (state.topic != null && state.more) {
      emit(state.copyWith(loading: true));

      var page = state.page + 1;
      var posts =
          await postRepository.fetchTopicPosts(state.topic!, page: page);
      var more = posts.length > 0;
      var newPosts = List.of(state.posts)..addAll(posts);
      emit(state.copyWith(
        posts: newPosts,
        page: page,
        more: more,
        loading: false,
      ));
    }
  }
}
