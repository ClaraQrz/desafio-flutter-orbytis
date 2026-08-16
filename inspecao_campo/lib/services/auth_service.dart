import 'package:dio/dio.dart';
import '../models/user.dart';
import 'api_client.dart';

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class LoginResult {
  final String accessToken;
  final User user;
  LoginResult({required this.accessToken, required this.user});
}

class AuthService {
  Future<LoginResult> login(String email, String password) async {
    try {
      final response = await ApiClient.dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final data = response.data;
      return LoginResult(
        accessToken: data['accessToken'] as String,
        user: User.fromJson(data['user'] as Map<String, dynamic>),
     );
    } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          final data = e.response?.data;
          final msg = (data is Map && data['message'] != null)
              ? data['message'] as String
              : 'Credenciais inválidas';
          throw AuthException(msg);
        }
      throw AuthException('Não foi possível conectar ao servidor. Verifique sua conexão.');
    }
  }
}