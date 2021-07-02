part of 'repositories.dart';

class PostRepository extends BaseRepository {
  Future<PageModel<Post>> fetchTopicPosts(Topic topic, {int page = 0}) async {
    var pageModel =
        await client.topicPosts(topic, page: page, filterPost: false);
    pageModel = pageModel.copyWith(
      data: pageModel.data
          .where((post) => post.postType == kDefaultPostType)
          .toList(),
    );
    return pageModel;
  }

  Future<Result<Post, String>> createPost(int topicId, String content) async {
    var error = '';
    var result;
    try {
      result = await client.postCreate(topicId, content);
    } catch (e) {
      error = '创建失败';
    }
    return error.isEmpty ? Success(result) : Failure(error);
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
