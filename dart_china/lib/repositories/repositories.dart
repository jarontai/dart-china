import 'package:discourse_api/discourse_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

late final DiscourseApiClient _client;
final Map<int, String> categorySlugMap = {};
final Map<int, User> userMap = {};

final TopicRepository topicRepository = TopicRepository();
final PostRepository postRepository = PostRepository();

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

  Future<List<Topic>> fetchLatest({int page = 0}) async {
    var result = <Topic>[];

    var topics = await client.topicList(latest: true, page: page);
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

  Future<bool> checkLatest() async {
    return _client.pollLatest();
  }

  Future<Topic> findTopic(int topicId) async {
    return await client.topicDetail(topicId);
  }
}

class PostRepository {
  DiscourseApiClient get client => _client;

  Future<List<Post>> fetchTopicPosts(Topic topic, {int page = 0}) async {
    var topics = await client.topicPosts(topic, page: page);
    return topics;
  }
}
