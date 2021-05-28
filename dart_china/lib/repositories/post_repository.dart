part of 'repositories.dart';

class PostRepository extends BaseRepository {
  Future<PageModel<Post>> fetchTopicPosts(Topic topic, {int page = 0}) async {
    var topics = await client.topicPosts(topic, page: page);
    return topics;
  }

  Future<Post> createPost(int topicId, String content) async {
    return await client.postCreate(topicId, content);
  }

  Future<PageModel<SearchResult>> search(String token,
      {int page = 1,
      String? categorySlug,
      DateTime? start,
      DateTime? end}) async {
    return await client.search(token,
        page: page, categorySlug: categorySlug, startDate: start, endDate: end);
  }
}
