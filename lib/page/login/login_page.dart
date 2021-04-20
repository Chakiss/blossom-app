import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/page/login/login_provider.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/text_field_stroke_black.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginProvider _loginProvider;

  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _loginProvider = Provider.of(context, listen: false);
    return Container(
      color: BlossomTheme.white,
      child: Center(
        child: Container(
          width: 80 * MediaQuery.of(context).size.width / 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/splashscreen.svg",
                width: 200,
                height: 200,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: BlossomText(
                  "email",
                  size: 16,
                  color: BlossomTheme.black,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              TextFieldStrokeBlack("email@email.com", textController: emailTextController,),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: BlossomText(
                  "password",
                  size: 16,
                  color: BlossomTheme.black,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              TextFieldStrokeBlack("", textController: passwordTextController,),
              SizedBox(
                height: 6,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: BlossomText(
                  "ลืมรหัสผ่าน",
                  size: 16,
                  color: BlossomTheme.black,
                ),
              ),
              ButtonPinkGradient(
                "เข้าสู่ระบบ",
                true,
                () {},
                radius: 6,
                height: 40,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 26),
                color: BlossomTheme.black,
                height: 1,
              ),
              ButtonPinkGradient("ลงทะเบียนใหม่", true, () {}, radius: 6, height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
