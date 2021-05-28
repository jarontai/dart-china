part of 'repositories.dart';

class TopicRepository extends BaseRepository {
  Future<PageModel<Topic>> fetchLatest(
      {int page = 0, int? categoryId, String? categorySlug}) async {
    var result = <Topic>[];

    var pageModel = await client.topicList(
        latest: true,
        page: page,
        categoryId: categoryId,
        categorySlug: categorySlug);
    for (var topic in pageModel.data) {
      topic.users?.forEach((user) {
        userMap.putIfAbsent(user.id, () => user);
      });
      User? poster;
      if (topic.posterIds != null && topic.posterIds!.isNotEmpty) {
        poster = userMap[topic.posterIds?.first];
      }

      var catId = topic.categoryId;
      result.add(topic.copyWith(
        categorySlug: categorySlugMap[catId],
        poster: poster,
      ));
    }

    return pageModel.copyWith(data: result);
  }

  Future<bool> checkLatest() async {
    return _client.pollLatest();
  }

  Future<Topic> findTopic(int topicId) async {
    return await client.topicDetail(topicId);
  }
}
