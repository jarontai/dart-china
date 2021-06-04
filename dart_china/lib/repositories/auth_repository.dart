part of 'repositories.dart';

class AuthRepository extends BaseRepository {
  Future<User?> login(String username, String password) async {
    return client.login(username, password);
  }

  Future<void> logout(String username) async {
    return client.logout(username);
  }

  Future<bool> checkLogin() async {
    return client.checkLogin();
  }

  Future<User> userInfo(String username) async {
    return client.userInfo(username);
  }

  Future<bool> checkUsername(String username) async {
    return client.checkUsername(username);
  }

  Future<bool> checkEmail(String email) async {
    return client.checkEmail(email);
  }

  Future<bool> register(String email, String username, String password) async {
    return client.register(email, username, password);
  }
}
