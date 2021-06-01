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

  fetchTopic(int topicId) async {
    emit(state.copyWith(
      status: TopicStatus.initial,
      postSuccess: false,
    ));
    var theTopic = await topicRepository.findTopic(topicId);
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
      var pageModel =
          await postRepository.fetchTopicPosts(state.topic!, page: page);
      var newPosts = List.of(state.posts)..addAll(pageModel.data);
      emit(state.copyWith(
        posts: newPosts,
        page: page,
        more: pageModel.hasNext,
        loading: false,
      ));
    }
  }

  togglePostReply(bool enable) {
    emit(state.copyWith(enableReply: enable));
  }

  createTopicPost(String content) async {
    assert(state.topic != null, 'Topic should not be null');
    emit(state.copyWith(
      status: TopicStatus.posting,
      postSuccess: false,
    ));
    var post = await postRepository.createPost(state.topic!.id, content);
    emit(state.copyWith(
      posts: List.of(state.posts)..add(post),
      status: TopicStatus.success,
      postSuccess: true,
    ));
  }
}
