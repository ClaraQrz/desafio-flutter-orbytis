import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/token_storage.dart';
import '../services/user_storage.dart';

class AuthRepository {
  AuthRepository({
    required this._authService,
    required this._tokenStorage,
    required this._userStorage,
  });

  final AuthService _authService;
  final TokenStorage _tokenStorage;
  final UserStorage _userStorage;

  Future<User> login(
    String email,
    String password,
  ) async {
    final result = await _authService.login(
      email,
      password,
    );

    await _tokenStorage.saveToken(
      result.accessToken,
    );

    await _userStorage.saveUser(
      result.user,
    );

    return result.user;
  }

  Future<User?> getSession() async {
    final token = await _tokenStorage.getToken();
    final user = await _userStorage.getUser();

    if (token == null || user == null) {
      await logout();
      return null;
    }

    return user;
  }

  Future<void> logout() async {
    await _tokenStorage.clearToken();
    await _userStorage.clearUser();
  }
}