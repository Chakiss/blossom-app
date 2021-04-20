import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/user_model.dart';
import 'package:blossom_clinic/page/splash_screen_page.dart';
import 'package:blossom_clinic/page/splash_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends BaseProvider with ChangeNotifier {

  UserModel _userModel;

  ProfileProvider(this._userModel);

  Future<void> logout(BuildContext context) async {
    await FacebookAuth.instance.logOut();
    clearUserData();
    _goToSplashScreen(context);
  }

  void clearUserData() {
    _userModel.facebookId = null;
    _userModel.email = null;
    _userModel.profilePath = null;
    _userModel.signInResponseModel = null;
    _userModel.profileResponseModel = null;
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