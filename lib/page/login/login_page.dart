import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/page/login/login_provider.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {

  LoginProvider _loginProvider;

  @override
  Widget build(BuildContext context) {
    _loginProvider = Provider.of(context, listen: false);
    return BaseScreen(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/splashscreen.svg"),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: ButtonPinkGradient(
                "เข้าสู่ระบบด้วย Facebook",
                true,
                () async {
                  _loginProvider.loginFacebook(context);
                },
                width: 60 * MediaQuery.of(context).size.width / 100,
                radius: 4,
                textSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
