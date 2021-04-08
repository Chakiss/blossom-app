import 'package:blossom_clinic/page/splash_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatelessWidget {

  SplashScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context, listen: false);
    provider.goToMainPage(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Container(
                // width: 80 * MediaQuery.of(context).size.width / 100,
                child: SvgPicture.asset("assets/splashscreen.svg")),
          ),
        ),
      ),
    );
  }
}
