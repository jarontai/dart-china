part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostInit extends PostEvent {
  final int topicId;

  PostInit({
    required this.topicId,
  });
}

class PostSubmit extends PostEvent {
  final int categoryId;
  final String title;
  final String raw;

  PostSubmit({
    required this.categoryId,
    required this.title,
    required this.raw,
  });
}
