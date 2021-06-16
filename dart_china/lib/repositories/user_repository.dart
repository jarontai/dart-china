part of 'repositories.dart';

class UserRepository extends BaseRepository {
  Future<User> userInfo(String username) async {
    return client.userInfo(username);
  }

  Future<User> userProfile(String username) async {
    return client.userInfo(username, withSummary: true, withActions: true);
  }

  Future<int?> uploadAvatar(int userId, List<int> bytes) async {
    return client.uploads(userId, bytes);
  }

  Future<bool> updateAvatar(String username, int uploadId) async {
    return client.updateAvatar(username, uploadId);
  }

  Future<bool> updateBio(String username, String bio) async {
    return client.updateUserInfo(username, bio: bio);
  }

  Future<PageModel<Notification>> notifications(String username,
      {int page = 0}) async {
    return client.notifications(username, page: page);
  }

  Future<bool> readNotification(String username, int id) async {
    return client.notificationRead(username, id);
  }

  Future<bool> readAllNotification(String username) async {
    return client.notificationReadAll(username);
  }
}
