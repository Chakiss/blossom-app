import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/doctor/doctor_provider.dart';
import 'package:blossom_clinic/page/main/main_page.dart';
import 'package:blossom_clinic/page/main/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreenProvider extends BaseProvider with ChangeNotifier {

  void goToMainPage(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(providers: [
          ChangeNotifierProvider(create: (BuildContext context) => MainProvider(),),
          ChangeNotifierProvider(create: (BuildContext context) => DoctorProvider(),),
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
