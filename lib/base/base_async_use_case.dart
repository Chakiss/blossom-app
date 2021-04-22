import 'package:blossom_clinic/model/base/result.dart';

abstract class BaseAsyncUseCase<P, R> {

  Future<Result<R>> execute(P parameter);
}