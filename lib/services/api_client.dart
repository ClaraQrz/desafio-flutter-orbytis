import 'package:dio/dio.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'token_storage.dart';

class ApiClient {
  static String get baseUrl {
    if (kIsWeb){
      return 'http://192.168.15.7:3000';
    } 
    if (Platform.isAndroid){
      return 'http://192.168.15.7:3000';
    }
    return 'http://192.168.15.7:3000';
    }

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final _tokenStorage = TokenStorage();
          final token = await _tokenStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
}