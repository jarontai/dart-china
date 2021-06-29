import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_china/models/models.dart';
import 'package:dart_china/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this._topicRepository, this._postRepository) : super(PostState());

  final TopicRepository _topicRepository;
  final PostRepository _postRepository;

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is PostInit) {
    } else if (event is PostSubmit) {}
  }
}
