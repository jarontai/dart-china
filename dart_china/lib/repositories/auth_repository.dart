part of 'repositories.dart';

class AuthRepository extends BaseRepository {
  Future<User> login(String username, String password) async {
    return await client.login(username, password);
  }

  Future<void> logout(String username) async {
    return await client.logout(username);
  }

  Future<bool> checkLogin() async {
    return await client.checkLogin();
  }

  Future<User> userInfo(String username) async {
    return await client.userInfo(username);
  }

  Future<List<String>> githubAuthData() async {
    return await client.oAuthData(provider: 'github');
  }
}
