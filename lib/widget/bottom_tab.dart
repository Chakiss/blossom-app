import 'package:blossom_clinic/doctor/doctor_page.dart';
import 'package:blossom_clinic/page/customer_home/customer_home_page.dart';
import 'package:blossom_clinic/page/drug/drug_page.dart';
import 'package:blossom_clinic/page/history/history_page.dart';
import 'package:blossom_clinic/page/main/main_provider.dart';
import 'package:blossom_clinic/page/profile/profile_page.dart';
import 'package:blossom_clinic/page/service/service_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../blossom_theme.dart';
import 'blossom_text.dart';

class BottomTab extends StatefulWidget {
  MainProvider mainProvider;
  int initIndex;

  BottomTab(this.mainProvider, {this.initIndex = 0});

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  var selectedPosition;

  @override
  void initState() {
    super.initState();
    selectedPosition = widget.initIndex;
  }

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
                  widget.mainProvider.setPage(CustomerHomePage());
                  setBottomMenu(0);
                }
              },
              child: Column(
                children: [
                  Image.asset(
                    "assets/ic_launcher.png",
                    width: 36,
                    height: 36,
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
                  widget.mainProvider.setPage(DoctorPage());
                  setBottomMenu(1);
                }
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/ic_consult_doctor.svg",
                    color: selectedPosition == 1 ? BlossomTheme.colorPrimary : BlossomTheme.black,
                  ),
                  BlossomText("แพทย์", color: selectedPosition == 1 ? BlossomTheme.colorPrimary : BlossomTheme.black)
                ],
              ),
            )),
            Expanded(
                child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (selectedPosition != 2) {
                  widget.mainProvider.setPage(ServicePage());
                  setBottomMenu(2);
                }
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/ic_review.svg",
                    color: selectedPosition == 2 ? BlossomTheme.colorPrimary : BlossomTheme.black,
                  ),
                  BlossomText("รีวิว", color: selectedPosition == 2 ? BlossomTheme.colorPrimary : BlossomTheme.black)
                ],
              ),
            )),
            Expanded(
                child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (selectedPosition != 3) {
                  widget.mainProvider.setPage(DrugPage());
                  setBottomMenu(3);
                }
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/ic_product.svg",
                    color: selectedPosition == 3 ? BlossomTheme.colorPrimary : BlossomTheme.black,
                  ),
                  BlossomText("ยา", color: selectedPosition == 3 ? BlossomTheme.colorPrimary : BlossomTheme.black)
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
