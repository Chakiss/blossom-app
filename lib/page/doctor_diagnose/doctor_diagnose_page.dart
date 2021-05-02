import 'package:blossom_clinic/page/doctor_diagnose/doctor_diagnose_provider.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/widget/acne_look_multi_choice.dart';
import 'package:blossom_clinic/widget/advice_self_multi_choice.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/skin_look_radio_group.dart';
import 'package:blossom_clinic/widget/text_field_stroke_black.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class DoctorDiagnosePage extends StatefulWidget {

  int _userConnectyCubeId;

  DoctorDiagnosePage(this._userConnectyCubeId);

  @override
  _DoctorDiagnosePageState createState() => _DoctorDiagnosePageState();
}

class _DoctorDiagnosePageState extends State<DoctorDiagnosePage> {
  DoctorDiagnoseProvider _provider;
  final treatPlanTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = Provider.of(context, listen: false);
    _provider.getUserProfile(context, widget._userConnectyCubeId);
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
              title: "วินิจฉัย",
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
                  _provider.skinType = skin;
                }),
                SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: BlossomText(
                    "วินิจฉัยโรค",
                    size: 16,
                    color: BlossomTheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AcneMultiChoice((acne) {
                  _provider.acneTypes = acne;
                }),
                SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: BlossomText(
                    "แผนการรักษา",
                    size: 16,
                    color: BlossomTheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextFieldStrokeBlack(
                  "",
                  height: 100,
                  textAlignVertical: TextAlignVertical.top,
                  // keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  textController: treatPlanTextController,
                ),
                SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: BlossomText(
                    "ข้อแนะนำวิธีการดูแลตัวเอง",
                    size: 16,
                    color: BlossomTheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AdviceSelfMultiChoice((value) {

                }),
                SizedBox(
                  height: 40,
                ),
                ButtonPinkGradient(
                  "ยืนยัน",
                  true,
                  () {
                    _goToDispensePage(context);
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
    );
  }

  void _goToDispensePage(BuildContext context) {
    Navigator.push(context, RouteManager.routeDispense(_provider.userProfileModel, _provider.shipnityCustomerModel));
  }
}
