import 'package:discourse_api/discourse_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

late final DiscourseApiClient _client;

initRepository() async {
  await dotenv.load();
  var siteUrl = dotenv.env['site_url'];
  _client = DiscourseApiClient.single(siteUrl!);
}

class TopicRepository {
  DiscourseApiClient get client => _client;

  Future<List<Topic>> latestTopics() async {
    var topics = await client.topicList(latest: true);
    return topics;
  }
}

class PostRepository {
  DiscourseApiClient get client => _client;

  Future<List<Post>> topicPosts(Topic topic, {int page = 1}) async {
    var topics = await client.topicPosts(topic, page: page);
    return topics;
  }
}
