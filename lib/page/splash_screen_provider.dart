import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/doctor/doctor_provider.dart';
import 'package:blossom_clinic/page/login/login_provider.dart';
import 'package:blossom_clinic/page/main/main_page.dart';
import 'package:blossom_clinic/page/main/main_provider.dart';
import 'package:blossom_clinic/page/profile/profile_provider.dart';
import 'package:blossom_clinic/page/service/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreenProvider extends BaseProvider with ChangeNotifier {

  void goToMainPage(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(providers: [
          ChangeNotifierProvider(create: (BuildContext context) => MainProvider(),),
          ChangeNotifierProvider(create: (BuildContext context) => DoctorProvider(),),
          ChangeNotifierProvider(create: (BuildContext context) => ServiceProvider(),),
          ChangeNotifierProvider(create: (BuildContext context) => LoginProvider(),),
          ChangeNotifierProvider(create: (BuildContext context) => ProfileProvider(),),
        ],
        child: MainPage(),);
      }));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
