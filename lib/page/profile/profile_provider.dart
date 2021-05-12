import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class ProfileProvider extends BaseProvider with ChangeNotifier {

  FacebookAuth _facebookAuth;
  FirebaseAuth _firebaseAuth;

  ProfileProvider(this._facebookAuth, this._firebaseAuth);

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    CubeChatConnection.instance.destroy();
    goToSplashScreen(context);
  }

  void goToSplashScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, RouteManager.routeSplashScreen(), (route) => false);
  }

  Future<void> syncAccountWithFacebook(BuildContext context) async {
    showProgressDialog(context);
    final result = await _facebookAuth.login();
    final AccessToken token = result.accessToken;
    final facebookAuthCredential = FacebookAuthProvider.credential(token.token);
    try {
      final linkResult = await _firebaseAuth.currentUser.linkWithCredential(facebookAuthCredential);
      Navigator.pop(context);
      showToast("เชื่อมต่อกับ Facebook สำเร็จ");
    } catch (e) {
      Navigator.pop(context);
      errorHandle.proceed(context, ErrorUtils.getErrorMessage(e));
    }
  }
}