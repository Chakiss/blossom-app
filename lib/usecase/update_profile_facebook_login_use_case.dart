import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/update_profile_facebook_login_model.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProfileFacebookLoginUseCase extends BaseAsyncUseCase<Map<String, dynamic>, UserProfileModel> {
  FirebaseFirestore _firestore;

  UpdateProfileFacebookLoginUseCase(this._firestore);

  @override
  Future<Result<UserProfileModel>> execute(Map<String, dynamic> parameter) async {
    try {
      final id = parameter["id"];
      UpdateProfileFacebookLoginModel requestModel = (parameter["requestModel"] as UpdateProfileFacebookLoginModel);
      final data = await _firestore.collection("patients").doc(id).set(requestModel.toJson());
      return Success(null);
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
