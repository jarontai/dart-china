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
        emit(state.copyWith(status: TopicStatus.loading));
        var theTopic = await _topicRepository.findTopic(event.topicId);
        emit(state.copyWith(
          topic: theTopic,
        ));
      }
      _fetchTopicPosts();
    } else if (event is TopicReply) {
      _createTopicPost(event.content);
    } else if (event is TopicReset) {
      _reset();
    }
  }

  _reset() {
    emit(state.copyWith(
      postSuccess: false,
      error: '',
    ));
  }

  _fetchTopicPosts() async {
    if (!state.hasMore) {
      return;
    }

    var page = state.page + 1;
    var pageModel =
        await _postRepository.fetchTopicPosts(state.topic!, page: page);
    var newPosts = List.of(state.posts)..addAll(pageModel.data);
    emit(state.copyWith(
      status: TopicStatus.success,
      posts: newPosts,
      page: page,
      hasMore: pageModel.hasNext,
    ));
  }

  _createTopicPost(String content) async {
    assert(state.topic != null, 'Topic should not be null');
    emit(state.copyWith(
      status: TopicStatus.posting,
      postSuccess: false,
    ));
    var postResult = await _postRepository.createPost(state.topic!.id, content);
    postResult.result((value) {
      emit(state.copyWith(
        status: TopicStatus.success,
        posts: List.of(state.posts)..add(value),
        postSuccess: true,
      ));
    }, (value) {
      emit(state.copyWith(
        status: TopicStatus.success,
        postSuccess: false,
      ));
    });
  }

  String buildTopicUrl(int topicId) {
    return _topicRepository.buildTopicUrl(topicId);
  }
}
