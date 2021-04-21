import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/page/register_second/register_second_page.dart';
import 'package:blossom_clinic/page/register_second/register_second_provider.dart';
import 'package:blossom_clinic/utils/no_animation_page_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class RegisterProvider extends BaseProvider with ChangeNotifier {
  void goToRegisterSecondPage(BuildContext context, String email, String password, String confirmPassword,
      String phoneNumber, String name, String lastName, String dateOfBirth) {
    print("$email $password $confirmPassword $phoneNumber $name $lastName $dateOfBirth");
    Navigator.push(context, NoAnimationPageRoute(builder: (BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) => RegisterSecondProvider(Injector.appInstance.get()),
          )
        ],
        child: RegisterSecondPage({
          "email" : email,
          "password" : password,
          "confirmPassword" : confirmPassword,
          "phoneNumber" : phoneNumber,
          "name" : name,
          "lastName" : lastName,
          "dateOfBirth" : dateOfBirth,
        }),
      );
    }));
  }
}
