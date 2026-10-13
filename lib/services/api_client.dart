import 'package:dio/dio.dart';

import 'token_storage.dart';

class ApiClient {
  static void Function()? onSessionExpired;

  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://192.168.15.7:3000',
  );

  static final TokenStorage _tokenStorage = TokenStorage();

  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              final token = await _tokenStorage.getToken();

              if (token != null && options.path != '/auth/login') {
                options.headers['Authorization'] = 'Bearer $token';
              }

              return handler.next(options);
            },
            onError: (error, handler) {
              if (error.response?.statusCode == 401 &&
                  error.requestOptions.path != '/auth/login') {
                onSessionExpired?.call();
              }
              return handler.next(error);
            },
          ),
        );
}
