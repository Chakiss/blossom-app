import 'package:dio/dio.dart';

class ErrorUtils {

  static Map<String, String> getErrorMessage(dynamic e) {
    print(e);
    String message;
    if (e is Response) {
      message = e.data;
    }
    return {"message" : "$message ?? $e"};
  }
}