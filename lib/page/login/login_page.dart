import 'dart:io';

import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/page/login/login_provider.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_login_apple.dart';
import 'package:blossom_clinic/widget/button_login_facebook.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/dialog/forgot_password_dialog.dart';
import 'package:blossom_clinic/widget/text_field_stroke_black.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginPage extends StatelessWidget {
  LoginProvider _provider;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    return Consumer<LoginProvider>(
      builder: (BuildContext context, LoginProvider value, Widget child) {
        return Material(
          child: Container(
            color: BlossomTheme.white,
            child: Center(
              child: SingleChildScrollView(
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
                      TextFieldStrokeBlack(
                        "email@email.com",
                        textController: _emailTextController,
                        keyboardType: TextInputType.emailAddress,
                        textAlignVertical: TextAlignVertical.top,
                      ),
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
                      TextFieldStrokeBlack(
                        "",
                        textController: _passwordTextController,
                        isPasswordType: true,
                        textAlignVertical: TextAlignVertical.top,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return ForgotPasswordDialog(
                                      title: "ลืมรหัสผ่าน",
                                      description: "กรุณากรอก email ที่ท่านได้ทำการลงทะเบียนไว้",
                                      positiveButton: "ตกลง",
                                      positiveListener: (email) {
                                        _provider.forgotPassword(context, email);
                                      },
                                      negativeButton: "ยกเลิก",
                                      negativeListener: () {
                                        Navigator.pop(dialogContext);
                                      });
                                });
                          },
                          child: BlossomText(
                            "ลืมรหัสผ่าน",
                            size: 16,
                            color: BlossomTheme.black,
                          ),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: BlossomText(
                      //     "ลืมรหัสผ่าน",
                      //     size: 16,
                      //     color: BlossomTheme.black,
                      //   ),
                      // ),
                      SizedBox(
                        height: 28,
                      ),
                      ButtonPinkGradient(
                        "เข้าสู่ระบบ",
                        true,
                        () {
                          _provider.login(context, _emailTextController.text, _passwordTextController.text);
                        },
                        width: MediaQuery.of(context).size.width,
                        // width: 56 * MediaQuery.of(context).size.width / 100,
                        radius: 6,
                        height: 44,
                      ),
                      // getSignInAppleButton(context),
                      // SizedBox(
                      //   height: 16,
                      // ),
                      // ButtonLoginFacebook(
                      //   "Sign in with Facebook",
                      //   true,
                      //       () {
                      //     _provider.loginWithFacebook(context);
                      //   },
                      //   radius: 6,
                      //   width: MediaQuery.of(context).size.width,
                      // width: 56 * MediaQuery.of(context).size.width / 100,
                      // height: 44,
                      // ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 26),
                        color: BlossomTheme.black,
                        height: 1,
                      ),
                      ButtonPinkGradient("ลงทะเบียนใหม่", true, () {
                        Navigator.push(context, RouteManager.routeRegister());
                      }, radius: 6, width: 56 * MediaQuery.of(context).size.width / 100, height: 46),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getSignInAppleButton(BuildContext context) {
    if (Platform.isIOS) {
      return Column(
        children: [
          SizedBox(
            height: 16,
          ),
          Container(
            child: ButtonLoginApple(
              "Sign in with Apple",
              true,
              () {
                _provider.loginWithApple(context);
              },
              radius: 6,
              width: MediaQuery.of(context).size.width,
              // width: 56 * MediaQuery.of(context).size.width / 100,
              height: 44,
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
