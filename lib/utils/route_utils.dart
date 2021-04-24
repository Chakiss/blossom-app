import 'package:blossom_clinic/doctor/doctor_provider.dart';
import 'package:blossom_clinic/page/doctor_diagnose/doctor_diagnose_page.dart';
import 'package:blossom_clinic/page/doctor_diagnose/doctor_diagnose_provider.dart';
import 'package:blossom_clinic/page/doctor_history/doctor_history_provider.dart';
import 'package:blossom_clinic/page/doctor_home/doctor_home_provider.dart';
import 'package:blossom_clinic/page/doctor_main/doctor_main_page.dart';
import 'package:blossom_clinic/page/doctor_main/doctor_main_provider.dart';
import 'package:blossom_clinic/page/history/history_provider.dart';
import 'package:blossom_clinic/page/login/login_page.dart';
import 'package:blossom_clinic/page/login/login_provider.dart';
import 'package:blossom_clinic/page/main/main_page.dart';
import 'package:blossom_clinic/page/main/main_provider.dart';
import 'package:blossom_clinic/page/profile/profile_provider.dart';
import 'package:blossom_clinic/page/service/service_provider.dart';
import 'package:blossom_clinic/page/splash_screen_page.dart';
import 'package:blossom_clinic/page/splash_screen_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class RouteUtils {

  static Route routeSplashScreen() => MaterialPageRoute(builder: (BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (BuildContext context) => SplashScreenProvider(FirebaseAuth.instance, Injector.appInstance.get(), Injector.appInstance.get()),)
    ],
      child: SplashScreenPage(),);
  });

  static Route routeLoginPage() => PageRouteBuilder(
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
  );

  static Route routeMainPage() => MaterialPageRoute(builder: (BuildContext context) {
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
  });

  static Route routeDoctorMainPage() => MaterialPageRoute(builder: (BuildContext context) {
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
  });

  static Route routeDoctorDiagnosePage() => MaterialPageRoute(builder: (BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return DoctorDiagnoseProvider();
          },
        )
      ],
      child: DoctorDiagnosePage(),
    );
  });
}
