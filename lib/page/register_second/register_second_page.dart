import 'package:blossom_clinic/page/register_second/register_second_provider.dart';
import 'package:blossom_clinic/widget/skin_look_radio_group.dart';
import 'package:blossom_clinic/widget/acne_treat.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/drug_allergy.dart';
import 'package:blossom_clinic/widget/acne_look_radio_group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class RegisterSecondPage extends StatefulWidget {
  Map<String, String> _profileData;

  RegisterSecondPage(this._profileData);

  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  RegisterSecondProvider _provider;
  var _acneTreatTextController = TextEditingController();
  var _drugAllergyTextController = TextEditingController();

  String skinType = "";
  String acneTypes = "";
  String acneCareNoted = "";
  String drugAllergyItems = "";

  @override
  void initState() {
    super.initState();
    _provider = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Scaffold(
        backgroundColor: BlossomTheme.white,
        body: Column(children: [
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
                  SkinLookRadioGroup((skin) {
                    skinType = skin;
                  }),
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
                  AcneLookRadioGroup((acne) {
                    acneTypes = acne;
                  }),
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
                  AcneTreat(_acneTreatTextController),
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
                  DrugAllergy(_drugAllergyTextController),
                  SizedBox(
                    height: 40,
                  ),
                  ButtonPinkGradient(
                    "ยืนยัน",
                    true,
                    () {
                      _provider.callServiceRegister(context, widget._profileData, skinType, acneTypes,
                          _acneTreatTextController.text, _drugAllergyTextController.text);
                    },
                    width: 30 * MediaQuery.of(context).size.width / 100,
                    height: 40,
                    radius: 6,
                  )
                ],
              ),
            ),
          )),
        ]),
      )
    ]);
  }
}
