import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/text_field_stroke_black.dart';
import 'package:blossom_clinic/widget/text_stroke_black.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../blossom_theme.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var confirmPasswordTextController = TextEditingController();
  var nameTextController = TextEditingController();
  var lastNameTextController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final dateFormat = DateFormat("d MMM yyyy", "TH");

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: BlossomTheme.white,
        ),
        Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 100 * MediaQuery.of(context).size.width / 100,
                child: Image.asset("assets/nav_bar.png"),
              ),
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
                        "email",
                        size: 16,
                        color: BlossomTheme.black,
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
                      textController: passwordTextController,
                      isPasswordType: true,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BlossomText(
                        "confirm password",
                        size: 16,
                        color: BlossomTheme.black,
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
                        "ชื่อ",
                        size: 16,
                        color: BlossomTheme.black,
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
                            initialDate: selectedDate,
                            // Refer step 1
                            firstDate: DateTime(1970),
                            lastDate: DateTime.now(),
                            builder: (BuildContext context, Widget child) {
                              return Theme(
                                data: ThemeData.dark().copyWith(
                                  colorScheme: ColorScheme.dark(
                                    primary: BlossomTheme.pink,
                                    onPrimary: BlossomTheme.white,
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
                        dateFormat.format(selectedDate),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            )),
            ButtonPinkGradient(
              "ต่อไป",
              true,
              () {},
              width: MediaQuery.of(context).size.width,
            )
          ],
        )
      ],
    );
  }
}
