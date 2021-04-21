import 'package:blossom_clinic/base/base_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

import '../splash_screen_page.dart';
import '../splash_screen_provider.dart';

class ProfileProvider extends BaseProvider with ChangeNotifier {

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    goToSplashScreen(context);
  }

  void goToSplashScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(providers: [
        ChangeNotifierProvider(create: (BuildContext context) => SplashScreenProvider(FirebaseAuth.instance, Injector.appInstance.get()),)
      ],
        child: SplashScreenPage(),);
    }), (route) => false);
  }
}