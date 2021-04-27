import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/update_profile_facebook_login_model.dart';
import 'package:blossom_clinic/usecase/update_profile_facebook_login_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FacebookUpdateProfileSecondProvider extends BaseProvider with ChangeNotifier {
  UpdateProfileFacebookLoginUseCase _updateProfileFacebookLoginUseCase;

  FacebookUpdateProfileSecondProvider(this._updateProfileFacebookLoginUseCase);

  Future<void> updateUserProfileFirestore(BuildContext context, String id, Map<String, String> profileData,
      String skinType, String acneTypes, String acneTreatText, String drugAllergyText) async {
    if (skinType?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณาเลือกลักษณะผิว"});
      return;
    }
    if (acneTypes?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณาเลือกลักษณะสิว"});
      return;
    }

    showProgressDialog(context);
    UpdateProfileFacebookLoginModel requestModel = UpdateProfileFacebookLoginModel(
      acneCaredNoted: acneTreatText,
      acneIsCared: acneTreatText.isNotEmpty ?? false,
      acneTypes: [int.parse(acneTypes)],
      birthDate: Timestamp(1,1),
      createdAt: Timestamp.now(),
      drugAllergyItems: [drugAllergyText],
      drugAllergyStatus: drugAllergyText.isNotEmpty ?? false,
      email: profileData["email"],
      firstName: profileData["name"],
      lastName: profileData["lastName"],
      phoneNumber: profileData["phoneNumber"].replaceFirst("0", "+66"),
      registeredChannel: "application",
      registeredNote: "",
      skinType: int.parse(skinType),
      updatedAt: Timestamp.now()
    );
    final result = await _updateProfileFacebookLoginUseCase.execute({"id": id, "requestModel": requestModel});
    Navigator.pop(context);
    // profileData["dateOfBirth"]
  }

  void goToLoginPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, RouteManager.routeMain(), (route) => false);
  }
}
