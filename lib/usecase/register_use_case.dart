import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/request/create_new_application_user_request_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_functions/cloud_functions.dart';

class RegisterUseCase extends BaseAsyncUseCase<CreateNewApplicationUserRequestModel, dynamic> {

  FirebaseFunctions _firebaseFunctions;

  RegisterUseCase(this._firebaseFunctions);

  @override
  Future<Result<dynamic>> execute(CreateNewApplicationUserRequestModel parameter) async {
    try {
      HttpsCallable callable = _firebaseFunctions.httpsCallable("users-createNewApplicationUser");
      final result = await callable.call(parameter.data.toJson());
      return Success(result.data);
    } catch (e) {
      print(e);
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
