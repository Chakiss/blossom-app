import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/usecase/get_doctor_profile_use_case.dart';
import 'package:blossom_clinic/usecase/get_user_profile_use_case.dart';
import 'package:blossom_clinic/utils/route_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SplashScreenProvider extends BaseProvider with ChangeNotifier {
  FirebaseAuth _firebaseAuth;
  GetUserProfileUseCase _getUserProfileUseCase;
  GetDoctorProfileUseCase _getDoctorProfileUseCase;

  SplashScreenProvider(this._firebaseAuth, this._getUserProfileUseCase, this._getDoctorProfileUseCase);

  Future<void> checkLogin(BuildContext context) async {
    _firebaseAuth.authStateChanges().listen((event) async {
      if (event == null) {
        _goToLoginPage(context);
      } else {
        _firebaseAuth.currentUser.getIdTokenResult().then((idTokenResult) async {
          if (idTokenResult.claims["role"] != "patient") {
            final result = await _getDoctorProfileUseCase.execute(event.uid);
            result.whenWithResult((userProfile) {
              _goToDoctorMainPage(context);
            }, (map) async {
              await FirebaseAuth.instance.signOut();
              _goToLoginPage(context);
            });
          } else {
            final result = await _getUserProfileUseCase.execute(event.uid);
            result.whenWithResult((userProfile) {
              _goToMainPage(context);
            }, (map) async {
              await FirebaseAuth.instance.signOut();
              _goToLoginPage(context);
            });
          }
        }).catchError((error) async {
          errorHandle.proceed(context, error);
        });
      }
    });
  }

  void _goToLoginPage(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      await Navigator.pushReplacement(
          context, RouteUtils.routeLoginPage());
    });
  }

  void _goToMainPage(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      await Navigator.pushReplacement(context, RouteUtils.routeMainPage());
    });
  }

  void _goToDoctorMainPage(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      await Navigator.pushReplacement(context, RouteUtils.routeDoctorMainPage());
    });
  }
}
