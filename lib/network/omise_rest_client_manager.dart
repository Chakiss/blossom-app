import 'dart:convert';

import 'package:dio/dio.dart';

class OmiseRestClientManager {

  Dio getDio() {
    final dio = Dio(); // Provide a dio instance
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    // dio.options.headers["Authorization"] = "Basic ${base64Encode(utf8.encode('skey_test_5n0xzn4kpsvxizlhvox'))}";
    return dio;
  }
}
