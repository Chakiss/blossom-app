
import 'package:blossom_clinic/page/splash_screen_page.dart';
import 'package:blossom_clinic/page/splash_screen_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

import 'blossom_theme.dart';

class BlossomClinicApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: BlossomTheme.white,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return SplashScreenProvider(FirebaseAuth.instance, Injector.appInstance.get(), Injector.appInstance.get());
            },
          )
        ],
        child: SplashScreenPage(),
      ),
    );
  }
}