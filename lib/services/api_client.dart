import 'package:dio/dio.dart';

import 'token_storage.dart';

class ApiClient {
  /// Endereço da API. Para outro ambiente, sem mexer no código:
  /// `flutter run --dart-define=API_BASE_URL=http://SEU_IP:3000`
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://192.168.15.7:3000',
  );

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final tokenStorage = TokenStorage();
          final token = await tokenStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
}