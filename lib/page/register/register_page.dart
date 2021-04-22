import 'package:blossom_clinic/page/register/register_provider.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/text_field_stroke_black.dart';
import 'package:blossom_clinic/widget/text_stroke_black.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterProvider _provider;
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var confirmPasswordTextController = TextEditingController();
  var phoneNumberTextController = TextEditingController();
  var nameTextController = TextEditingController();
  var lastNameTextController = TextEditingController();
  DateTime selectedDate;
  final dateFormat = DateFormat("d MMM yyyy", "TH");

  @override
  void initState() {
    _provider = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlossomTheme.white,
      body: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 100 * MediaQuery.of(context).size.width / 100,
                  child: Image.asset("assets/nav_bar.png"),
                ),
              ),
              SafeArea(child: Toolbar(title: "ข้อมูลผู้ใช้",)),
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              width: 80 * MediaQuery.of(context).size.width / 100,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlossomText(
                      "อีเมล",
                      size: 16,
                      color: BlossomTheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFieldStrokeBlack(
                    "",
                    textController: emailTextController,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlossomText(
                      "รหัสผ่าน",
                      size: 16,
                      color: BlossomTheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFieldStrokeBlack(
                    "",
                    textController: passwordTextController,
                    isPasswordType: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlossomText(
                      "ยืนยันรหัสผ่าน",
                      size: 16,
                      color: BlossomTheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFieldStrokeBlack(
                    "",
                    textController: confirmPasswordTextController,
                    isPasswordType: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlossomText(
                      "เบอร์โทรศัพท์",
                      size: 16,
                      color: BlossomTheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFieldStrokeBlack(
                    "",
                    textController: phoneNumberTextController,
                    maxLength: 10,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlossomText(
                      "ชื่อ",
                      size: 16,
                      color: BlossomTheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFieldStrokeBlack(
                    "",
                    textController: nameTextController,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlossomText(
                      "นามสกุล",
                      size: 16,
                      color: BlossomTheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFieldStrokeBlack(
                    "",
                    textController: lastNameTextController,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlossomText(
                      "วันเกิด",
                      size: 16,
                      color: BlossomTheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      final DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          // Refer step 1
                          firstDate: DateTime(1970),
                          lastDate: DateTime.now(),
                          builder: (BuildContext context, Widget child) {
                            return Theme(
                              data: ThemeData.dark().copyWith(
                                colorScheme: ColorScheme.dark(
                                  primary: BlossomTheme.pink,
                                  onPrimary: BlossomTheme.black,
                                  surface: BlossomTheme.darkPink,
                                  onSurface: BlossomTheme.black,
                                ),
                                dialogBackgroundColor: BlossomTheme.white,
                              ),
                              child: child,
                            );
                          });
                      if (picked != null)
                        setState(() {
                          selectedDate = picked;
                        });
                    },
                    child: TextStrokeBlack(
                      selectedDate == null ? "" : dateFormat.format(selectedDate),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ButtonPinkGradient(
                    "ต่อไป",
                    true,
                    () {
                      _provider.goToRegisterSecondPage(
                          context,
                          emailTextController.text,
                          passwordTextController.text,
                          confirmPasswordTextController.text,
                          phoneNumberTextController.text,
                          nameTextController.text,
                          lastNameTextController.text,
                          selectedDate == null ? null : DateFormat("yyyy-MM-dd").format(selectedDate));
                    },
                    width: 30 * MediaQuery.of(context).size.width / 100,
                    height: 40,
                    radius: 6,
                  )
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
