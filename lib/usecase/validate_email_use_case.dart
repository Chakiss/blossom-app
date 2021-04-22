import 'package:blossom_clinic/base/base_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';

class ValidateEmailUseCase extends BaseUseCase<String, bool> {
  @override
  Result<bool> execute(String parameter) {
    RegExp emailRegExp = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (emailRegExp.hasMatch(parameter)) {
      return Success(true);
    } else {
      return Success(false);
    }
  }

}