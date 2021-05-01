import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/create_new_application_user.dart';
import 'package:blossom_clinic/model/request/create_new_application_user_request_model.dart';
import 'package:blossom_clinic/usecase/get_user_profile_use_case.dart';
import 'package:blossom_clinic/usecase/login_use_case.dart';
import 'package:blossom_clinic/usecase/register_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterSecondProvider extends BaseProvider with ChangeNotifier {
  RegisterUseCase _registerUseCase;
  LoginUseCase _loginUseCase;
  GetUserProfileUseCase _getUserProfileUseCase;
  FirebaseAuth _firebaseAuth;

  RegisterSecondProvider(this._registerUseCase, this._loginUseCase, this._getUserProfileUseCase, this._firebaseAuth);

  Future<void> callServiceRegister(BuildContext context, Map<String, String> profileData, String skinType,
      String acneTypes, bool isAcneTreat, String acneTreatText, bool isDrugAllergy, String drugAllergyText) async {
    if (skinType?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณาเลือกลักษณะผิว"});
      return;
    }
    if (acneTypes?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณาเลือกลักษณะสิว"});
      return;
    }
    if (isAcneTreat == null) {
      errorHandle.proceed(context, {"message": "กรุณาเลือกประวัติการรักษาสิว"});
      return;
    }
    if (isDrugAllergy == null) {
      errorHandle.proceed(context, {"message": "กรุณาระบุประวัติแพ้ยา"});
      return;
    }

    showProgressDialog(context);
    final data = CreateNewApplicationUser(
        profileData["email"],
        profileData["phoneNumber"],
        profileData["password"],
        profileData["confirmPassword"],
        profileData["name"],
        profileData["lastName"],
        profileData["dateOfBirth"],
        skinType,
        acneTypes,
        isAcneTreat ? acneTreatText ?? "" : "",
        isDrugAllergy ? drugAllergyText ?? "" : "");
    print(data.toJson());
    final requestModel = CreateNewApplicationUserRequestModel(data);
    final result = await _registerUseCase.execute(requestModel);
    Navigator.pop(context);
    result.whenWithResult((data) {
      showToast("ลงทะเบียนสำเร็จ ระบบกำลังนำคุณเข้าสู่ระบบ");
      _login(context, profileData["email"], profileData["password"]);
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }

  Future<void> _login(BuildContext context, String email, String password) async {
    showProgressDialog(context);
    final result = await _loginUseCase.execute({"email": email, "password": password});
    result.whenWithResult((data) async {
      final getProfileResult = await _getUserProfileUseCase.execute(data.user.uid);
      Navigator.pop(context);
      getProfileResult.whenWithResult((data) {
        _goToMainPage(context);
      }, (map) async {
        await _firebaseAuth.signOut();
        _goToLoginPage(context);
      });
    }, (map) {
      Navigator.pop(context);
      errorHandle.proceed(context, map);
    });
  }

  void _goToMainPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, RouteManager.routeMain(), (route) => false);
  }

  void _goToLoginPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, RouteManager.routeLogin(), (route) => false);
  }
}
