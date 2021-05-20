import 'dart:async';

import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/update_profile_facebook_login_request_model.dart';
import 'package:blossom_clinic/usecase/get_user_profile_use_case.dart';
import 'package:blossom_clinic/usecase/login_apple_use_case.dart';
import 'package:blossom_clinic/usecase/login_facebook_use_case.dart';
import 'package:blossom_clinic/usecase/update_profile_facebook_login_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FacebookUpdateProfileSecondProvider extends BaseProvider with ChangeNotifier {
  UpdateProfileFacebookLoginUseCase _updateProfileFacebookLoginUseCase;
  GetUserProfileUseCase _getUserProfileUseCase;
  LoginFacebookUseCase _loginFacebookUseCase;
  LoginAppleUseCase _loginAppleUseCase;
  Timer _timer;

  FacebookUpdateProfileSecondProvider(this._updateProfileFacebookLoginUseCase, this._getUserProfileUseCase, this._loginFacebookUseCase, this._loginAppleUseCase);

  Future<void> updateUserProfileFirestore(BuildContext context, Map<String, dynamic> mapResult, String skinType,
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
    final requestModel = UpdateProfileFacebookLoginRequestModel(
        (mapResult["userCredential"] as UserCredential).user.uid,
        mapResult["email"],
        mapResult["phoneNumber"],
        mapResult["name"],
        mapResult["lastName"],
        mapResult["dateOfBirth"],
        skinType,
        acneTypes.substring(0, acneTypes.length - 1),
        isAcneTreat ? acneTreatText ?? "" : "",
        isDrugAllergy ? drugAllergyText ?? "" : "");
    final result = await _updateProfileFacebookLoginUseCase.execute(requestModel);
    Navigator.pop(context);
    result.whenWithResult((data) async {
      showToast("อัพเดทข้อมูลผู้ใช้สำเร็จ");
      if (mapResult.containsKey("appleCredential")) {
        loginWithApple(context);
      } else {
        loginWithFacebook(context);
      }
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }

  Future<void> loginWithApple(BuildContext context) async {
    showProgressDialog(context);
    final result = await _loginAppleUseCase.execute("");
    result.whenWithResult((mapResult) async {
      final userCredential = mapResult["userCredential"] as UserCredential;
      final profileResult = await _getUserProfileUseCase.execute(userCredential.user.uid);
      Navigator.pop(context);
      profileResult.whenWithResult((data) {
        if (data != null) {
          _goToMainPage(context);
        }
      }, (map) {
        errorHandle.proceed(context, map);
      });
    }, (map) {
      Navigator.pop(context);
      errorHandle.proceed(context, map);
    });
  }

  Future<void> loginWithFacebook(BuildContext context) async {
    showProgressDialog(context);
    final result = await _loginFacebookUseCase.execute("");
    result.whenWithResult((mapResult) async {
      final userCredential = mapResult["userCredential"] as UserCredential;
      final profileResult = await _getUserProfileUseCase.execute(userCredential.user.uid);
      Navigator.pop(context);
      profileResult.whenWithResult((data) {
        if (data != null) {
          _goToMainPage(context);
        }
      }, (map) {
        errorHandle.proceed(context, map);
      });
    }, (map) {
      Navigator.pop(context);
      errorHandle.proceed(context, map);
    });
  }

  void _goToMainPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, RouteManager.routeMain(), (route) => false);
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
