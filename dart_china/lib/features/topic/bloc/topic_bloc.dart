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
          posts: List.of(theTopic.posts ?? []),
        ));
      }
      _fetchTopicPosts();
    } else if (event is TopicReply) {
      _createTopicPost(event.content);
    }
  }

  _fetchTopicPosts() async {
    if (!state.more) {
      return;
    }

    var page = state.page + 1;
    if (page > 0) {
      emit(state.copyWith(
        paging: true,
      ));
    }
    var pageModel =
        await _postRepository.fetchTopicPosts(state.topic!, page: page);
    var newPosts = List.of(state.posts)..addAll(pageModel.data);
    emit(state.copyWith(
      posts: newPosts,
      page: page,
      more: pageModel.hasNext,
    ));
  }

  _createTopicPost(String content) async {
    assert(state.topic != null, 'Topic should not be null');
    emit(state.copyWith(
      status: TopicStatus.posting,
      postSuccess: false,
    ));
    var post = await _postRepository.createPost(state.topic!.id, content);
    emit(state.copyWith(
      posts: List.of(state.posts)..add(post),
      status: TopicStatus.success,
      postSuccess: true,
    ));
    emit(state.copyWith(postSuccess: false));
  }
}
