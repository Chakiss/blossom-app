import 'package:dio/dio.dart';

class RestClientManager {

  Dio getDio() {
    final dio = Dio(); // Provide a dio instance
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }
}
