import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/doctor/doctor_provider.dart';
import 'package:blossom_clinic/page/history/history_provider.dart';
import 'package:blossom_clinic/page/main/main_page.dart';
import 'package:blossom_clinic/page/main/main_provider.dart';
import 'package:blossom_clinic/page/profile/profile_provider.dart';
import 'package:blossom_clinic/page/service/service_provider.dart';
import 'package:blossom_clinic/usecase/login_use_case.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class LoginProvider extends BaseProvider with ChangeNotifier {
  LoginUseCase _loginUseCase;
  LoginProvider(this._loginUseCase);

  Future<void> login(BuildContext context, String email, String password) async {
    showProgressDialog(context);
    final result = await _loginUseCase.execute({"email": email, "password": password});
    Navigator.pop(context);
    result.whenWithResult((data) {
      goToMainPage(context);
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }

  void goToMainPage(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      await Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) => MainProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => DoctorProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => HistoryProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => ServiceProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => LoginProvider(Injector.appInstance.get()),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => ProfileProvider(),
            ),
          ],
          child: MainPage(),
        );
      }));
    });
  }
}
