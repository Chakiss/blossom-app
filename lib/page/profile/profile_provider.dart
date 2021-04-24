import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/utils/route_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProfileProvider extends BaseProvider with ChangeNotifier {

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    goToSplashScreen(context);
  }

  void goToSplashScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, RouteUtils.routeSplashScreen(), (route) => false);
  }
}