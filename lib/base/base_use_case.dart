import 'package:blossom_clinic/model/base/result.dart';

abstract class BaseUseCase<P, R> {

  Future<Result<R>> execute(P parameter);
}