import 'package:meta/meta.dart';

@sealed
class Result<T> {

  R whenWithResult<R>(
      R Function(T) result,
      R Function(Map<String, String>) errorMap,
      ) {
    if (this is Success<T>) {
      return result((this as Success<T>).data ?? null);
    } else if (this is Error) {
      return errorMap((this as Error).errorMap ?? {"message" : "exception"});
    } else {
      throw new Exception('Unhendled part, could be anything');
    }
  }
}

class Success<T> extends Result<T> {
  final T data;

  Success(this.data);
}

class Error<T> extends Result<T> {
  final Map<String, String> errorMap;

  Error(this.errorMap);
}