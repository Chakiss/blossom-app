import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/usecase/validate_email_use_case.dart';
import 'package:blossom_clinic/usecase/validate_phone_number_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterProvider extends BaseProvider with ChangeNotifier {

  ValidateEmailUseCase _validateEmailUseCase;
  ValidatePhoneNumberUseCase _validatePhoneNumberUseCase;

  RegisterProvider(this._validateEmailUseCase, this._validatePhoneNumberUseCase);

  void goToRegisterSecondPage(BuildContext context, String email, String password, String confirmPassword,
      String phoneNumber, String name, String lastName, String dateOfBirth) {
    print("$email $password $confirmPassword $phoneNumber $name $lastName $dateOfBirth");
    if (email?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message" : "กรุณากรอกอีเมล์"});
      return;
    }
    if (!(_validateEmailUseCase.execute(email) as Success<bool>).data) {
      errorHandle.proceed(context, {"message" : "กรุณากรอกอีเมล์ให้ถูกต้อง"});
      return;
    }
    if (password?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message" : "กรุณากรอกรหัสผ่าน"});
      return;
    }
    if (confirmPassword?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message" : "กรุณากรอกยืนยันรหัสผ่าน"});
      return;
    }
    if (password != confirmPassword) {
      errorHandle.proceed(context, {"message" : "กรุณาใส่รหัสผ่านทั้งสองช่องให้เหมือนกัน"});
      return;
    }
    if (phoneNumber?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message" : "กรุณากรอกเบอร์โทรศัพท์"});
      return;
    }
    if (!(_validatePhoneNumberUseCase.execute(phoneNumber) as Success<bool>).data) {
      errorHandle.proceed(context, {"message" : "กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง"});
      return;
    }
    if (name?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message" : "กรุณากรอกชื่อ"});
      return;
    }
    if (lastName?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message" : "กรุณากรอกนามสกุล"});
      return;
    }
    if (dateOfBirth == null) {
      errorHandle.proceed(context, {"message" : "กรุณาเลือกวันเดือนปีเกิด"});
      return;
    }
    Navigator.push(context, RouteManager.routeRegisterSecond({
      "email" : email,
      "password" : password,
      "confirmPassword" : confirmPassword,
      "phoneNumber" : phoneNumber,
      "name" : name,
      "lastName" : lastName,
      "dateOfBirth" : dateOfBirth,
    }));
  }
}
