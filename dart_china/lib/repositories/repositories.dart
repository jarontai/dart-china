import 'package:discourse_api/discourse_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:result_type/result_type.dart';

export 'package:discourse_api/discourse_api.dart' show DiscourseApiClient;

part 'auth_repository.dart';
part 'post_repository.dart';
part 'topic_repository.dart';
part 'user_repository.dart';

late final DiscourseApiClient _client;
final Map<int, String> categorySlugMap = {};
final Map<int, User> userMap = {};

const kDefaultPostType = 1;

typedef ApiClientInited = Function(DiscourseApiClient client);

initRepository(
  String siteUrl, {
  String? cdnUrl,
  ApiClientInited? onClientCreated,
}) async {
  // Env string must be const!!
  const proxyAddress = String.fromEnvironment('PROXY_ADDRESS');
  if (proxyAddress.isNotEmpty) {
    print('--- Proxy Enabled: $proxyAddress ---');
  } else {
    print('--- Proxy Not Enabled: $proxyAddress ---');
  }

  final dir = await getApplicationDocumentsDirectory();
  _client = DiscourseApiClient.single(siteUrl,
      cdnUrl: cdnUrl,
      cookieDir: dir.path,
      proxyAddress: proxyAddress,
      timeout: 30);
  onClientCreated?.call(_client);

  final categories = await _client.categories();
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
