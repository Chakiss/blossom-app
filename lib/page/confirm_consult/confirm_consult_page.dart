import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient_small.dart';
import 'package:blossom_clinic/widget/consult_doctor_day_item.dart';
import 'package:blossom_clinic/widget/doctor_duration_choice.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';

import '../../blossom_theme.dart';

class ConfirmConsultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ToolbarBack(title: "ยืนยันการจอง",),
          Spacer(
            flex: 1,
          ),
          Container(
            width: 80 * MediaQuery.of(context).size.width / 100,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: BlossomText(
                    "ระยะเวลาการปรึกษาแพทย์",
                    color: BlossomTheme.black,
                    size: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                DoctorDurationChoice(listener: (value) {
                  print("Prew $value");
                },),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  height: 1,
                  color: BlossomTheme.lightGray,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: BlossomText(
                    "วันที่ต้องการปรึกษาแพทย์",
                    color: BlossomTheme.black,
                    size: 15,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(0.0),
                  crossAxisSpacing: 10.0,
                  crossAxisCount: 5,
                  mainAxisSpacing:  14.0,
                  childAspectRatio: 3 / 1.5,
                  children: <Widget>[
                    ConsultDoctorDayItem("14 เมษา", () {}),
                    ConsultDoctorDayItem("14 เมษา", () {}),
                    ConsultDoctorDayItem("14 เมษา", () {}),
                    ConsultDoctorDayItem("14 เมษา", () {}),
                    ConsultDoctorDayItem("14 เมษา", () {}),
                    ConsultDoctorDayItem("14 เมษา", () {}),
                    ConsultDoctorDayItem("14 เมษา", () {}),
                    ConsultDoctorDayItem("14 เมษา", () {}),
                    ConsultDoctorDayItem("14 เมษา", () {}),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  height: 1,
                  color: BlossomTheme.lightGray,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: BlossomText(
                    "ค่าใช้จ่ายในการปรึกษา 500 บาท",
                    color: BlossomTheme.black,
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 52,
                ),
                ButtonPinkGradientSmall("ยืนยัน", () {

                })
              ],
            ),
          ),
          Spacer(
            flex: 4,
          ),
        ],
      ),
    );
  }
}
