part of 'repositories.dart';

class TopicRepository extends BaseRepository {
  Future<PageModel<Topic>> fetchLatest(
      {int page = 0, int? categoryId, String? categorySlug}) async {
    var pageModel = await client.topicList(
        latest: true,
        page: page,
        categoryId: categoryId,
        categorySlug: categorySlug);

    var result = _prepare(pageModel.data);
    return pageModel.copyWith(data: result);
  }

  Future<bool> checkLatest() async {
    return _client.pollLatest();
  }

  Future<Topic> findTopic(int topicId) async {
    return await client.topicDetail(topicId);
  }

  Future<List<Topic>> recentReadTopics() async {
    final topics = await client.recentRead();
    return _prepare(topics);
  }

  List<Topic> _prepare(List<Topic> topics) {
    var result = <Topic>[];
    for (var topic in topics) {
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
    return result;
  }

  String buildTopicUrl(int topicId) {
    return _client.buildTopicUrl(topicId);
  }
}
