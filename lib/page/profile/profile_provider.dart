import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/page/splash_screen_page.dart';
import 'package:blossom_clinic/page/splash_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends BaseProvider with ChangeNotifier {

  Future<void> logout(BuildContext context) async {
    await FacebookAuth.instance.logOut();
    _goToSplashScreen(context);
  }

  void _goToSplashScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(providers: [
        ChangeNotifierProvider(create: (BuildContext context) => SplashScreenProvider(),),
      ],
        child: SplashScreenPage(),);
    }));
  }
}