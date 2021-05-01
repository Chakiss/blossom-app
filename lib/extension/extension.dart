import 'package:dio/dio.dart';

extension ResponseExtensions<T> on Response<T> {

  bool isSuccess() {
    return this.statusCode >= 200 && this.statusCode <= 299 && this.data != null;
  }
}