import 'package:blossom_clinic/page/facebook_update_profile_second/facebook_update_profile_second_provider.dart';
import 'package:blossom_clinic/widget/acne_look_radio_group.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/acne_treat.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/drug_allergy.dart';
import 'package:blossom_clinic/widget/skin_look_radio_group.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class FacebookUpdateProfileSecondPage extends StatefulWidget {
  Map<String, dynamic> _mapResult;

  FacebookUpdateProfileSecondPage(this._mapResult);

  @override
  _FacebookUpdateProfileSecondPageState createState() => _FacebookUpdateProfileSecondPageState();
}

class _FacebookUpdateProfileSecondPageState extends State<FacebookUpdateProfileSecondPage> {
  FacebookUpdateProfileSecondProvider _provider;
  var _acneTreatTextController = TextEditingController();
  var _drugAllergyTextController = TextEditingController();

  String _skinType = "";
  String _acneTypes = "";
  bool isAcneTreat;
  bool isDrugAllergy;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlossomTheme.white,
      body: Column(children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 100 * MediaQuery.of(context).size.width / 100,
                child: Image.asset("assets/nav_bar.png"),
              ),
            ),
            SafeArea(
                child: ToolbarBack(
              title: "ประวัติทั่วไป",
            )),
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
                    "ลักษณะผิว",
                    size: 16,
                    color: BlossomTheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SkinLookRadioGroup((skin) {
                  _skinType = skin;
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
                  _acneTypes = acne;
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
                AcneTreat(_acneTreatTextController, (boolean) {
                  isAcneTreat = boolean;
                }),
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
                DrugAllergy(_drugAllergyTextController, (boolean) {
                  isDrugAllergy = boolean;
                }),
                SizedBox(
                  height: 40,
                ),
                ButtonPinkGradient(
                  "ยืนยัน",
                  true,
                  () {
                    _provider.updateUserProfileFirestore(context, widget._mapResult, _skinType, _acneTypes, isAcneTreat,
                        _acneTreatTextController.text, isDrugAllergy, _drugAllergyTextController.text);
                  },
                  width: 30 * MediaQuery.of(context).size.width / 100,
                  height: 40,
                  radius: 6,
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        )),
      ]),
    );
  }
}
