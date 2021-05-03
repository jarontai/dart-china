import 'package:discourse_api/discourse_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

late final DiscourseApiClient _client;
final Map<int, String> categorySlugMap = {};
final Map<int, User> userMap = {};

initRepository() async {
  await dotenv.load();
  var siteUrl = dotenv.env['site_url'];
  var cdnUrl = dotenv.env['cdn_url'];
  _client = DiscourseApiClient.single(siteUrl!, cdnUrl: cdnUrl);
  var categories = await _client.categories();
  if (categories.isNotEmpty) {
    for (var cat in categories) {
      categorySlugMap[cat.id] = cat.slug;
    }
  }
}

class TopicRepository {
  DiscourseApiClient get client => _client;

  int page = 0;
  bool hasNext = true;

  Future<List<Topic>> latestTopics({bool refresh = false}) async {
    var result = <Topic>[];
    if (!hasNext) {
      return result;
    }

    if (refresh) {
      page = 0;
    }

    var topics = await client.topicList(latest: true, page: page);
    page++;
    hasNext = topics.hasNext;

    for (var topic in topics.data) {
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

  Future<bool> hasNewTopic() async {
    return _client.pollLatest();
  }
}

class PostRepository {
  DiscourseApiClient get client => _client;

  Future<List<Post>> topicPosts(Topic topic, {int page = 1}) async {
    var topics = await client.topicPosts(topic, page: page);
    return topics;
  }
}
