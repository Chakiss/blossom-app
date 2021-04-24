import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/doctor/doctor_provider.dart';
import 'package:blossom_clinic/page/doctor_history/doctor_history_provider.dart';
import 'package:blossom_clinic/page/doctor_home/doctor_home_provider.dart';
import 'package:blossom_clinic/page/history/history_provider.dart';
import 'package:blossom_clinic/page/login/login_page.dart';
import 'package:blossom_clinic/page/login/login_provider.dart';
import 'package:blossom_clinic/page/main/main_page.dart';
import 'package:blossom_clinic/page/main/main_provider.dart';
import 'package:blossom_clinic/page/profile/profile_provider.dart';
import 'package:blossom_clinic/page/service/service_provider.dart';
import 'package:blossom_clinic/usecase/get_doctor_profile_use_case.dart';
import 'package:blossom_clinic/usecase/get_user_profile_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

import 'doctor_main/doctor_main_page.dart';
import 'doctor_main/doctor_main_provider.dart';

class SplashScreenProvider extends BaseProvider with ChangeNotifier {
  FirebaseAuth _firebaseAuth;
  GetUserProfileUseCase _getUserProfileUseCase;
  GetDoctorProfileUseCase _getDoctorProfileUseCase;

  SplashScreenProvider(this._firebaseAuth, this._getUserProfileUseCase, this._getDoctorProfileUseCase);

  Future<void> checkLogin(BuildContext context) async {
    _firebaseAuth.authStateChanges().listen((event) async {
      if (event == null) {
        _goToLoginPage(context);
      } else {
        _firebaseAuth.currentUser.getIdTokenResult().then((idTokenResult) async {
          if (idTokenResult.claims["role"] != "patient") {
            final result = await _getDoctorProfileUseCase.execute(event.uid);
            result.whenWithResult((userProfile) {
              _goToDoctorMainPage(context);
            }, (map) async {
              await FirebaseAuth.instance.signOut();
              _goToLoginPage(context);
            });
          } else {
            final result = await _getUserProfileUseCase.execute(event.uid);
            result.whenWithResult((userProfile) {
              _goToMainPage(context);
            }, (map) async {
              await FirebaseAuth.instance.signOut();
              _goToLoginPage(context);
            });
          }
        }).catchError((error) async {
          errorHandle.proceed(context, error);
        });
      }
    });
  }

  void _goToLoginPage(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      await Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                      create: (BuildContext context) =>
                          LoginProvider(Injector.appInstance.get(), Injector.appInstance.get(), Injector.appInstance.get(), FirebaseAuth.instance)),
                ],
                child: LoginPage(),
              );
            },
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 1000),
          ));
    });
  }

  void _goToMainPage(BuildContext context) {
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
              create: (BuildContext context) =>
                  LoginProvider(Injector.appInstance.get(), Injector.appInstance.get(), Injector.appInstance.get(), FirebaseAuth.instance),
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

  void _goToDoctorMainPage(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      await Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) => DoctorMainProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => DoctorHomeProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => DoctorHistoryProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => ServiceProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => ProfileProvider(),
            ),
          ],
          child: DoctorMainPage(),
        );
      }));
    });
  }
}
