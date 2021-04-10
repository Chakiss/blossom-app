import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/doctor/doctor_provider.dart';
import 'package:blossom_clinic/page/main/main_page.dart';
import 'package:blossom_clinic/page/main/main_provider.dart';
import 'package:blossom_clinic/page/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

class LoginProvider extends BaseProvider with ChangeNotifier {

  Future<void> loginFacebook(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login(loginBehavior: LoginBehavior.WEB_VIEW_ONLY); // by the fault we request the email and the public profile
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken =  result.accessToken;
      Navigator.pop(context);
      _goToMainPage(context);
    }
  }

  void _goToMainPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(providers: [
        ChangeNotifierProvider(create: (BuildContext context) => MainProvider(),),
        ChangeNotifierProvider(create: (BuildContext context) => DoctorProvider(),),
        ChangeNotifierProvider(create: (BuildContext context) => LoginProvider(),),
        ChangeNotifierProvider(create: (BuildContext context) => ProfileProvider(),),
      ],
      child: MainPage(),);
    }));
  }
}