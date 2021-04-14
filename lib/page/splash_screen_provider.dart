import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/doctor/doctor_provider.dart';
import 'package:blossom_clinic/model/request/sign_in_request_model.dart';
import 'package:blossom_clinic/page/history/history_provider.dart';
import 'package:blossom_clinic/page/login/login_provider.dart';
import 'package:blossom_clinic/page/main/main_page.dart';
import 'package:blossom_clinic/page/main/main_provider.dart';
import 'package:blossom_clinic/page/profile/profile_provider.dart';
import 'package:blossom_clinic/page/service/service_provider.dart';
import 'package:blossom_clinic/usecase/login_facebook_use_case.dart';
import 'package:blossom_clinic/usecase/login_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class SplashScreenProvider extends BaseProvider with ChangeNotifier {

  LoginUseCase _loginUseCase;
  LoginFacebookUseCase _loginFacebookUseCase;

  SplashScreenProvider(this._loginUseCase, this._loginFacebookUseCase);

  Future<void> checkLogin(BuildContext context) async {
    final AccessToken accessToken = await FacebookAuth.instance.accessToken;
    if (accessToken != null) {
      final result = await _loginFacebookUseCase.execute(context, FacebookAuth.instance);
      result.whenWithResult((data) {
        goToMainPage(context);
      }, (statusModel) {
        goToMainPage(context);
      });
    } else {
      await _loginUseCase.execute(SignInRequestModel("blossomapp", "1234"));
      goToMainPage(context);
    }
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
              create: (BuildContext context) => DoctorProvider(Injector.appInstance.get()),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => HistoryProvider(Injector.appInstance.get(), Injector.appInstance.get()),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => ServiceProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => LoginProvider(Injector.appInstance.get()),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => ProfileProvider(Injector.appInstance.get()),
            ),
          ],
          child: MainPage(),
        );
      }));
    });
  }
}
