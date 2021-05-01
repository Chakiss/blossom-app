import 'package:blossom_clinic/model/base/result.dart';
import 'package:dio/dio.dart';

abstract class BaseAsyncUseCase<P, R> {

  Future<Result<R>> execute(P parameter);

}

extension ResponseExtensions on Response<dynamic> {

  bool isSuccess() {
    return this.statusCode >= 200 && this.statusCode <= 299 && this.data != null;
  }
}