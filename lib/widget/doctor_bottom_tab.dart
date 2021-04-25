import 'package:blossom_clinic/page/doctor_history/doctor_history_page.dart';
import 'package:blossom_clinic/page/doctor_home/doctor_home_page.dart';
import 'package:blossom_clinic/page/doctor_main/doctor_main_provider.dart';
import 'package:blossom_clinic/page/doctor_profile/doctor_profile_page.dart';
import 'package:blossom_clinic/page/drug/drug_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../blossom_theme.dart';
import 'blossom_text.dart';

class DoctorBottomTab extends StatefulWidget {

  DoctorMainProvider mainProvider;
  DoctorBottomTab(this.mainProvider);

  @override
  _DoctorBottomTabState createState() => _DoctorBottomTabState();
}

class _DoctorBottomTabState extends State<DoctorBottomTab> {
  var selectedPosition = 0;

  void setBottomMenu(int position) {
    setState(() {
      selectedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: BlossomTheme.blackAlpha,
          offset: Offset(0, -8),
          blurRadius: 10.0,
        )
      ]),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        color: BlossomTheme.white,
        child: Row(
          children: [
            Expanded(
                child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (selectedPosition != 0) {
                  widget.mainProvider.setPage(DoctorHomePage());
                  setBottomMenu(0);
                }
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/ic_consult_doctor.svg",
                    color: selectedPosition == 0 ? BlossomTheme.colorPrimary : BlossomTheme.black,
                  ),
                  BlossomText("หน้าแรก", color: selectedPosition == 0 ? BlossomTheme.colorPrimary : BlossomTheme.black)
                ],
              ),
            )),
            Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (selectedPosition != 1) {
                      widget.mainProvider.setPage(DoctorHistoryPage());
                      setBottomMenu(1);
                    }
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/ic_history.svg",
                        color: selectedPosition == 1? BlossomTheme.colorPrimary : BlossomTheme.black,
                      ),
                      BlossomText("รายการ", color: selectedPosition == 1 ? BlossomTheme.colorPrimary : BlossomTheme.black)
                    ],
                  ),
                )),
            Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (selectedPosition != 2) {
                      widget.mainProvider.setPage(DrugPage());
                      setBottomMenu(2);
                    }
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/ic_product.svg",
                        color: selectedPosition == 2 ? BlossomTheme.colorPrimary : BlossomTheme.black,
                      ),
                      BlossomText("ยา", color: selectedPosition == 2 ? BlossomTheme.colorPrimary : BlossomTheme.black)
                    ],
                  ),
                )),
            Expanded(
                child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (selectedPosition != 3) {
                  widget.mainProvider.setPage(DoctorProfilePage());
                  setBottomMenu(3);
                }
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/ic_consult_doctor.svg",
                    color: selectedPosition == 3 ? BlossomTheme.colorPrimary : BlossomTheme.black,
                  ),
                  BlossomText("ข้อมูลส่วนตัว",
                      color: selectedPosition == 3 ? BlossomTheme.colorPrimary : BlossomTheme.black)
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
