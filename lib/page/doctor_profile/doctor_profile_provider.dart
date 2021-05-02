import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class DoctorProfileProvider extends BaseProvider with ChangeNotifier {

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await signOut();
    goToSplashScreen(context);
  }

  void goToSplashScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, RouteManager.routeSplashScreen(), (route) => false);
  }
}