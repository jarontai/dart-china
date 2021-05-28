part of 'repositories.dart';

class PostRepository extends BaseRepository {
  Future<PageModel<Post>> fetchTopicPosts(Topic topic, {int page = 0}) async {
    var topics = await client.topicPosts(topic, page: page);
    return topics;
  }

  Future<Post> createPost(int topicId, String content) async {
    return await client.postCreate(topicId, content);
  }
}
