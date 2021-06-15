part of 'repositories.dart';

class AuthRepository extends BaseRepository {
  Future<Result<User, String?>> login(String username, String password) async {
    var user;
    var msg;
    try {
      user = await client.login(username, password);
    } catch (e) {
      msg = e.toString();
    }

    if (user != null) {
      return Success(user);
    } else {
      return Failure(msg);
    }
  }

  Future<void> logout(String username) async {
    return client.logout(username);
  }

  Future<bool> checkLogin() async {
    return client.checkLogin();
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
