import 'package:discourse_api/discourse_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

part 'topic_repository.dart';
part 'post_repository.dart';

late final DiscourseApiClient _client;
final Map<int, String> categorySlugMap = {};
final Map<int, User> userMap = {};

const kPostType = 1;

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

abstract class BaseRepository {
  DiscourseApiClient get client => _client;
}

class CategoryRepository extends BaseRepository {
  Future<List<Category>> fetchAll() async {
    return client.categories();
  }
}
