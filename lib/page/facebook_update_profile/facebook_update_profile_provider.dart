import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/usecase/validate_phone_number_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:flutter/material.dart';

class FacebookUpdateProfileProvider extends BaseProvider with ChangeNotifier {
  ValidatePhoneNumberUseCase _validatePhoneNumberUseCase;

  FacebookUpdateProfileProvider(this._validatePhoneNumberUseCase);

  Future<void> goToFacebookUpdateProfileSecondPage(BuildContext context, Map<String, dynamic> mapResult, String email, String phoneNumber,
      String name, String lastName, String dateOfBirth) async {
    if (email?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณากรอกอีเมล์"});
      return;
    }
    if (phoneNumber?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณากรอกเบอร์โทรศัพท์"});
      return;
    }
    if (!(_validatePhoneNumberUseCase.execute(phoneNumber) as Success<bool>).data) {
      errorHandle.proceed(context, {"message": "กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง"});
      return;
    }
    if (name?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณากรอกชื่อ"});
      return;
    }
    if (lastName?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณากรอกนามสกุล"});
      return;
    }
    if (dateOfBirth == null) {
      errorHandle.proceed(context, {"message": "กรุณาเลือกวันเดือนปีเกิด"});
      return;
    }
    mapResult["email"] = email;
    mapResult["phoneNumber"] = phoneNumber;
    mapResult["name"] = name;
    mapResult["lastName"] = lastName;
    mapResult["dateOfBirth"] = dateOfBirth;
    Navigator.push(
        context,
        RouteManager.routeFacebookUpdateProfileSecond(mapResult));
  }
}
