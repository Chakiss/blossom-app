import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/usecase/get_doctor_profile_use_case.dart';
import 'package:blossom_clinic/usecase/get_user_profile_use_case.dart';
import 'package:blossom_clinic/usecase/login_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends BaseProvider with ChangeNotifier {
  LoginUseCase _loginUseCase;
  GetUserProfileUseCase _getUserProfileUseCase;
  GetDoctorProfileUseCase _getDoctorProfileUseCase;
  FirebaseAuth _firebaseAuth;

  LoginProvider(this._loginUseCase, this._getUserProfileUseCase, this._getDoctorProfileUseCase, this._firebaseAuth);

  Future<void> login(BuildContext context, String email, String password) async {
    showProgressDialog(context);
    final result = await _loginUseCase.execute({"email": email, "password": password});
    result.whenWithResult((data) async {
      _firebaseAuth.currentUser.getIdTokenResult().then((idTokenResult) async {
        if (idTokenResult.claims["role"] != "patient") {
          final getDoctorProfileResult = await _getDoctorProfileUseCase.execute(data.user.uid);
          Navigator.pop(context);
          getDoctorProfileResult.whenWithResult((userProfile) {
            _goToDoctorMainPage(context);
          }, (map) async {
            await _firebaseAuth.signOut();
            errorHandle.proceed(context, map);
          });
        } else {
          final getProfileResult = await _getUserProfileUseCase.execute(data.user.uid);
          Navigator.pop(context);
          getProfileResult.whenWithResult((data) {
            _goToMainPage(context);
          }, (map) async {
            await _firebaseAuth.signOut();
            errorHandle.proceed(context, map);
          });
        }
      }).catchError((error) async {
        errorHandle.proceed(context, error);
      });
    }, (map) {
      Navigator.pop(context);
      errorHandle.proceed(context, map);
    });
  }

  void _goToMainPage(BuildContext context) {
      Navigator.pushReplacement(context, RouteManager.routeMain());
  }

  void _goToDoctorMainPage(BuildContext context) {
      Navigator.pushReplacement(context, RouteManager.routeDoctorMainPage());
  }
}
