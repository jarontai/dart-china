import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../models/models.dart';
import '../../../repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'topic_event.dart';
part 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  TopicBloc(this._topicRepository, this._postRepository) : super(TopicState());

  final TopicRepository _topicRepository;
  final PostRepository _postRepository;

  @override
  Stream<Transition<TopicEvent, TopicState>> transformEvents(
      Stream<TopicEvent> events,
      TransitionFunction<TopicEvent, TopicState> transitionFn) {
    return super.transformEvents(
        events.debounceTime(Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<TopicState> mapEventToState(
    TopicEvent event,
  ) async* {
    if (event is TopicFetch) {
      if (event.fetchTopic) {
        yield state.copyWith(status: TopicStatus.loading);
        final theTopic = await _topicRepository.findTopic(event.topicId);
        yield state.copyWith(
          topic: theTopic,
        );
      }

      if (state.hasMore) {
        yield await _fetchTopicPosts();
      }
    } else if (event is TopicReply) {
      yield state.copyWith(
        status: TopicStatus.posting,
        postSuccess: false,
      );

      yield await _createTopicPost(event.content);
    } else if (event is TopicReset) {
      yield state.copyWith(
        postSuccess: false,
        error: '',
      );
    }
  }

  Future<TopicState> _fetchTopicPosts() async {
    if (!state.hasMore) {
      return state;
    }

    var page = state.page + 1;
    var pageModel =
        await _postRepository.fetchTopicPosts(state.topic!, page: page);
    var newPosts = List.of(state.posts)..addAll(pageModel.data);
    return state.copyWith(
      status: TopicStatus.success,
      posts: newPosts,
      page: page,
      hasMore: pageModel.hasNext,
    );
  }

  Future<TopicState> _createTopicPost(String content) async {
    assert(state.topic != null, 'Topic should not be null');

    var postResult = await _postRepository.createPost(state.topic!.id, content);
    if (postResult.isSuccess) {
      return state.copyWith(
        status: TopicStatus.success,
        posts: List.of(state.posts)..add(postResult.success),
        postSuccess: true,
      );
    }
    return state.copyWith(
      status: TopicStatus.success,
      postSuccess: false,
    );
  }

  String buildTopicUrl(int topicId) {
    return _topicRepository.buildTopicUrl(topicId);
  }
}
