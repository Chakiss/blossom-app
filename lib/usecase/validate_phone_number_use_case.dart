import 'package:blossom_clinic/base/base_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';

class ValidatePhoneNumberUseCase extends BaseUseCase<String, bool> {
  @override
  Result<bool> execute(String parameter) {
    if (parameter.length == 10) {
      if (parameter.startsWith("0")) {
        return Success(true);
      } else {
        return Success(false);
      }
    } else {
      return Success(false);
    }
  }

}