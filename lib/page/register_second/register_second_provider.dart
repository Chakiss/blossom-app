import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/create_new_application_user.dart';
import 'package:blossom_clinic/model/request/create_new_application_user_request_model.dart';
import 'package:blossom_clinic/page/login/login_page.dart';
import 'package:blossom_clinic/page/login/login_provider.dart';
import 'package:blossom_clinic/usecase/register_use_case.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class RegisterSecondProvider extends BaseProvider with ChangeNotifier {

  RegisterUseCase _registerUseCase;

  RegisterSecondProvider(this._registerUseCase);

  Future<void> callServiceRegister(BuildContext context, Map<String, String> profileData, String skinType,
      String acneTypes, String acneTreatText, String drugAllergyText) async {

    if (skinType?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message" : "กรุณาเลือกลักษณะผิว"});
      return;
    }
    if (acneTypes?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message" : "กรุณาเลือกลักษณะสิว"});
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
        acneTreatText,
        drugAllergyText);
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
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(providers: [
        ChangeNotifierProvider(create: (BuildContext context) => LoginProvider(Injector.appInstance.get(), Injector.appInstance.get()),)
      ],
        child: LoginPage(),);
    }), (route) => false);
  }
}
