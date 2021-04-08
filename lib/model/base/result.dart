import 'package:meta/meta.dart';
import '../status_model.dart';

@sealed
class Result<T> {

  R whenWithResult<R>(
      R Function(T) result,
      R Function(StatusModel) statusModel,
      ) {
    if (this is Success<T>) {
      return result((this as Success<T>).data);
    } else if (this is Error) {
      return statusModel((this as Error).statusModel);
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
  final StatusModel statusModel;

  Error(this.statusModel);
}