import '../models/session.dart';
import '../network/api_client.dart';

class AuthRepository {
  AuthRepository(this._client);

  final ApiClient _client;

  Future<Session> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    return Session.fromJson(
      response['data'] as Map<String, dynamic>? ?? const {},
    );
  }
}
