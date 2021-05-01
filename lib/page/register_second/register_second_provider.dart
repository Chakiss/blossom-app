import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/create_new_application_user.dart';
import 'package:blossom_clinic/model/request/create_new_application_user_request_model.dart';
import 'package:blossom_clinic/usecase/register_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:flutter/material.dart';

class RegisterSecondProvider extends BaseProvider with ChangeNotifier {
  RegisterUseCase _registerUseCase;

  RegisterSecondProvider(this._registerUseCase);

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
      showToast("ลงทะเบียนสำเร็จ คุณสามารถเข้าสู่ระบบด้วย email และ password ที่ได้ทำการลงทะเบียนไว้");
      goToLoginPage(context);
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }

  void goToLoginPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, RouteManager.routeLogin(), (route) => false);
  }
}
