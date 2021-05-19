import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/usecase/get_doctor_profile_use_case.dart';
import 'package:blossom_clinic/usecase/get_user_profile_use_case.dart';
import 'package:blossom_clinic/usecase/login_apple_use_case.dart';
import 'package:blossom_clinic/usecase/login_facebook_use_case.dart';
import 'package:blossom_clinic/usecase/login_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginProvider extends BaseProvider with ChangeNotifier {
  LoginUseCase _loginUseCase;
  LoginFacebookUseCase _loginFacebookUseCase;
  LoginAppleUseCase _loginAppleUseCase;
  GetUserProfileUseCase _getUserProfileUseCase;
  GetDoctorProfileUseCase _getDoctorProfileUseCase;
  FirebaseAuth _firebaseAuth;
  FacebookAuth _facebookAuth;

  LoginProvider(this._loginUseCase, this._loginFacebookUseCase, this._loginAppleUseCase, this._getUserProfileUseCase, this._getDoctorProfileUseCase, this._firebaseAuth, this._facebookAuth);

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

  Future<void> loginWithFacebook(BuildContext context) async {
    showProgressDialog(context);
    final result = await _loginFacebookUseCase.execute("");
    result.whenWithResult((mapResult) async {
      final userCredential = mapResult["userCredential"] as UserCredential;
      userCredential.user.getIdTokenResult().then((idTokenResult) async {
        if ("doctor" == idTokenResult?.claims["role"] ?? "") {
          final getDoctorProfileResult = await _getDoctorProfileUseCase.execute(userCredential.user.uid);
          Navigator.pop(context);
          getDoctorProfileResult.whenWithResult((userProfile) {
            _goToDoctorMainPage(context);
          }, (map) async {
            await _firebaseAuth.signOut();
            errorHandle.proceed(context, map);
          });
        } else {
          final profileResult = await _getUserProfileUseCase.execute(userCredential.user.uid);
          Navigator.pop(context);
          profileResult.whenWithResult((data) {
            if (data == null) {
              _goToFacebookUpdateProfile(context, mapResult);
            } else {
              _goToMainPage(context);
            }
          }, (map) {
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

  Future<void> loginWithApple(BuildContext context) async {
    showProgressDialog(context);
    final result = await _loginAppleUseCase.execute("");
    result.whenWithResult((mapResult) async {
      final userCredential = mapResult["userCredential"] as UserCredential;
      userCredential.user.getIdTokenResult().then((idTokenResult) async {
        if ("doctor" == idTokenResult?.claims["role"] ?? "") {
          final getDoctorProfileResult = await _getDoctorProfileUseCase.execute(userCredential.user.uid);
          Navigator.pop(context);
          getDoctorProfileResult.whenWithResult((userProfile) {
            _goToDoctorMainPage(context);
          }, (map) async {
            await _firebaseAuth.signOut();
            errorHandle.proceed(context, map);
          });
        } else {
          final profileResult = await _getUserProfileUseCase.execute(userCredential.user.uid);
          Navigator.pop(context);
          profileResult.whenWithResult((data) {
            if (data == null) {
              _goToFacebookUpdateProfile(context, mapResult);
            } else {
              _goToMainPage(context);
            }
          }, (map) {
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
      Navigator.pushReplacement(context, RouteManager.routeDoctorMain());
  }

  void _goToFacebookUpdateProfile(BuildContext context, Map<String, dynamic> mapResult) async {
    final userData = await _facebookAuth.getUserData();
    String email = userData["email"] ?? "";
    String name = userData["name"] ?? "";
    Navigator.push(context, RouteManager.routeFacebookUpdateProfile(email, name, mapResult));
  }
}
