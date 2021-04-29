import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/update_profile_facebook_login_request_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_functions/cloud_functions.dart';

class UpdateProfileFacebookLoginUseCase extends BaseAsyncUseCase<UpdateProfileFacebookLoginRequestModel, dynamic> {
  FirebaseFunctions _firebaseFunctions;

  UpdateProfileFacebookLoginUseCase(this._firebaseFunctions);

  @override
  Future<Result<dynamic>> execute(UpdateProfileFacebookLoginRequestModel parameter) async {
    try {
      HttpsCallable callable = _firebaseFunctions.httpsCallable("users-updateApplicationUser");
      final result = await callable.call(parameter.toJson());
      return Success(result.data);
    } catch (e) {
      print(e);
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
