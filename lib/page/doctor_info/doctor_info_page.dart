
import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/response/doctor_info.dart';
import 'package:blossom_clinic/page/confirm_consult/confirm_consult_page.dart';
import 'package:blossom_clinic/page/confirm_consult/confirm_consult_provider.dart';
import 'package:blossom_clinic/page/doctor_info/doctor_info_provider.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorInfoPage extends StatelessWidget {
  DoctorInfo doctorInfo;

  DoctorInfoPage(this.doctorInfo);

  DoctorInfoProvider _doctorInfoProvider;

  @override
  Widget build(BuildContext context) {
    _doctorInfoProvider = Provider.of(context, listen: false);
    _doctorInfoProvider.callServiceGetDoctorDateReserve(context, doctorInfo?.cubeId ?? "0");
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
                  Consumer<DoctorInfoProvider>(builder: (BuildContext context, DoctorInfoProvider value, Widget child) {
                    if (value.dateReserveList == null) {
                      return BlossomProgressIndicator();
                    } else {
                      return GridView.count(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.all(0.0),
                        crossAxisSpacing: 10.0,
                        crossAxisCount: 4,
                        mainAxisSpacing: 28.0,
                        childAspectRatio: 3 / 1.5,
                        children: value.dateReserveList,
                      );
                      return BlossomProgressIndicator();
                    }
                  },)
                ],
              ),
            ),
          ),
          Consumer<DoctorInfoProvider>(builder: (BuildContext context, DoctorInfoProvider value, Widget child) {
            return ButtonPinkGradient("ต่อไป", value.dateReserveModel != null ,() {
              _goToConfirmConsultPage(context);
            },
            width: MediaQuery.of(context).size.width,
            height: 60,);
          },)
        ],
      ),
    );
  }

  void _goToConfirmConsultPage(BuildContext context) {
    Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) {
      return MultiProvider(providers: [
        ChangeNotifierProvider(create: (BuildContext context) => ConfirmConsultProvider(),)
      ],
      child: ConfirmConsultPage(doctorInfo, _doctorInfoProvider.dateReserveModel),);
    }));
  }
}
