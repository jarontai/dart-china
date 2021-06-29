// Re-export the models of discourse_api
export 'package:discourse_api/discourse_api.dart'
    show
        Topic,
        Post,
        User,
        Category,
        UserSummary,
        UserAction,
        Notification,
        NotificationData,
        NotificationType,
        SearchResult;

class PostArguments {
  final int? postId;
  final int? topicId;
  final bool isTopic;

  PostArguments({
    this.postId,
    this.topicId,
    this.isTopic = true,
  });
}
