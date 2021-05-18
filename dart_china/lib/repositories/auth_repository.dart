part of 'repositories.dart';

class AuthRepository extends BaseRepository {
  Future<User> login(String username, String password) async {
    return await client.login(username, password);
  }

  Future<void> logout(String username) async {
    return await client.logout(username);
  }
}
