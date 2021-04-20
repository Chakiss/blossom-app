import 'package:blossom_clinic/widget/acne_look_radio_group.dart';
import 'package:blossom_clinic/widget/acne_treat.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/drug_allergy.dart';
import 'package:blossom_clinic/widget/skin_look_radio_group.dart';
import 'package:flutter/material.dart';

import '../../blossom_theme.dart';

class RegisterSecondPage extends StatefulWidget {
  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: BlossomTheme.white,
      ),
      Column(children: [
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                width: 100 * MediaQuery.of(context).size.width / 100, child: Image.asset("assets/nav_bar.png"))),
        Expanded(
            child: SingleChildScrollView(
          child: Container(
            width: 80 * MediaQuery.of(context).size.width / 100,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BlossomText(
                    "ลักษณะผิว",
                    size: 16,
                    color: BlossomTheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AcneLookRadioGroup(),
                SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: BlossomText(
                    "ลักษณะสิว",
                    size: 16,
                    color: BlossomTheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SkinLookRadioGroup(),
                SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: BlossomText(
                    "เคยรักษาสิว?",
                    size: 16,
                    color: BlossomTheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AcneTreat(),
                SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: BlossomText(
                    "ประวัติแพ้ยา",
                    size: 16,
                    color: BlossomTheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: BlossomText(
                    "ยาที่แพ้",
                    size: 16,
                    color: BlossomTheme.black,
                  ),
                ),
                DrugAllergy(),
                SizedBox(
                  height: 40,
                ),
                ButtonPinkGradient(
                  "ยืนยัน",
                  true,
                  () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  width: 30 * MediaQuery.of(context).size.width / 100,
                  height: 40,
                  radius: 6,
                )
              ],
            ),
          ),
        )),
      ])
    ]);
  }
}
