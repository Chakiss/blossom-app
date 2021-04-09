import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/response/doctor_info.dart';
import 'package:blossom_clinic/page/confirm_consult/confirm_consult_page.dart';
import 'package:blossom_clinic/page/confirm_consult/confirm_consult_provider.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/consult_doctor_day_item.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorInfoPage extends StatelessWidget {
  DoctorInfo doctorInfo;

  DoctorInfoPage(this.doctorInfo);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          ToolbarBack(
            title: doctorInfo?.profileTitle ?? "",
          ),
          Expanded(
            child: Container(
              width: 80 * MediaQuery.of(context).size.width / 100,
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(doctorInfo.profileImg),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlossomText(
                              doctorInfo?.profileTitle ?? "",
                              color: BlossomTheme.pink,
                              size: 20,
                            ),
                            BlossomText("${doctorInfo?.firstName ?? ""} ${doctorInfo?.lastName ?? ""}",
                                color: BlossomTheme.black, size: 17)
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 28),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: BlossomText(
                          "วันที่ต้องการปรึกษาแพทย์",
                          color: BlossomTheme.black,
                          size: 15,
                        )),
                  ),
                  Container(
                    height: 16,
                  ),
                  Expanded(
                    child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(0.0),
                      crossAxisSpacing: 10.0,
                      crossAxisCount: 5,
                      mainAxisSpacing: 28.0,
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
                        ConsultDoctorDayItem("14 เมษา", () {})
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ButtonPinkGradient("ต่อไป", () {
            _goToConfirmConsultPage(context);
          }),
        ],
      ),
    );
  }

  void _goToConfirmConsultPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(providers: [
        ChangeNotifierProvider(create: (BuildContext context) => ConfirmConsultProvider(),)
      ],
      child: ConfirmConsultPage(),);
    }));
  }
}
