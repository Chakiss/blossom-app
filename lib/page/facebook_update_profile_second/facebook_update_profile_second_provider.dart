import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/usecase/update_profile_facebook_login_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:flutter/material.dart';

class FacebookUpdateProfileSecondProvider extends BaseProvider with ChangeNotifier {
  UpdateProfileFacebookLoginUseCase _updateProfileFacebookLoginUseCase;

  FacebookUpdateProfileSecondProvider(this._updateProfileFacebookLoginUseCase);

  Future<void> updateUserProfileFirestore(BuildContext context, Map<String, dynamic> mapResult,
      String skinType, String acneTypes, String acneTreatText, String drugAllergyText) async {
    if (skinType?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณาเลือกลักษณะผิว"});
      return;
    }
    if (acneTypes?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณาเลือกลักษณะสิว"});
      return;
    }

    // Navigator.pop(context);
    // profileData["dateOfBirth"]
  }

  void goToLoginPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, RouteManager.routeMain(), (route) => false);
  }
}
