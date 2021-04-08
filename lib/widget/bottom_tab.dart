import 'package:blossom_clinic/doctor/doctor_page.dart';
import 'package:blossom_clinic/page/main/main_provider.dart';
import 'package:blossom_clinic/page/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../blossom_theme.dart';
import 'blossom_text.dart';

class BottomTab extends StatefulWidget {
  MainProvider mainProvider;

  BottomTab(this.mainProvider);

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
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
                widget.mainProvider.setPage(DoctorPage());
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/ic_consult_doctor.svg",
                    color: BlossomTheme.colorPrimary,
                  ),
                  BlossomText("พบแพทย์")
                ],
              ),
            )),
            Expanded(
                child: Column(
              children: [
                SvgPicture.asset(
                  "assets/ic_consult_doctor.svg",
                  color: BlossomTheme.colorPrimary,
                ),
                BlossomText("บริการ")],
            )),
            Expanded(
                child: Column(
              children: [
                SvgPicture.asset(
                  "assets/ic_consult_doctor.svg",
                  color: BlossomTheme.colorPrimary,
                ),
                BlossomText("สาขา")],
            )),
            Expanded(
                child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                widget.mainProvider.setPage(ProfilePage());
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/ic_consult_doctor.svg",
                    color: BlossomTheme.colorPrimary,
                  ),
                  BlossomText("ข้อมูลส่วนตัว")],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
