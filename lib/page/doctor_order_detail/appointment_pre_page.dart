import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/widget/blossom_image.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentPrePage extends StatelessWidget {
  Pre _pre;

  AppointmentPrePage(this._pre);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 7 * MediaQuery.of(context).size.width / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlossomText(
            DateFormat("วันที่ d MMMM yyyy", "TH").format(_pre.createdAt.toDate()),
            fontWeight: FontWeight.bold,
            size: 18,
          ),
          SizedBox(
            height: 16,
          ),
          BlossomText(
            "ระยะเวลาที่เป็นสิว",
            fontWeight: FontWeight.bold,
            size: 18,
          ),
          SizedBox(
            height: 10,
          ),
          BlossomText(
            "${_pre.acnePeriod} เดือน",
            size: 16,
          ),
          SizedBox(
            height: 16,
          ),
          BlossomText(
            "ประวัติการรักษาสิว",
            fontWeight: FontWeight.bold,
            size: 18,
          ),
          SizedBox(
            height: 10,
          ),
          BlossomText(
            "${_pre.acneCared.isEmpty ? "-" : _pre.acneCared}",
            size: 16,
          ),
          SizedBox(
            height: 16,
          ),
          BlossomText(
            "ประวัติการเปลี่ยนผลิตภัณฑ์",
            fontWeight: FontWeight.bold,
            size: 18,
          ),
          SizedBox(
            height: 10,
          ),
          BlossomText(
            "${_pre.changeProduct.isEmpty ? "-" : _pre.acneCared}",
            size: 16,
          ),
          SizedBox(
            height: 16,
          ),
          BlossomText(
            "สภาวะความเครียด",
            fontWeight: FontWeight.bold,
            size: 18,
          ),
          SizedBox(
            height: 10,
          ),
          BlossomText(
            "${_pre.isStressed ? "มี" : "ไม่มี"}",
            size: 16,
          ),
          SizedBox(
            height: 16,
          ),
          BlossomText(
            "สภาวะการนอน (นอนน้อย, นอนดึก)",
            fontWeight: FontWeight.bold,
            size: 18,
          ),
          SizedBox(
            height: 10,
          ),
          BlossomText(
            "${_pre.sleepDeprivation ? "มี" : "ไม่มี"}",
            size: 16,
          ),
          SizedBox(
            height: 16,
          ),
          BlossomText(
            "สภาวะประจำเดือน",
            fontWeight: FontWeight.bold,
            size: 18,
          ),
          SizedBox(
            height: 10,
          ),
          BlossomText(
            "${_pre.normalMenstruation ? "ไม่ปกติ" : "ปกติ"}",
            size: 16,
          ),
          SizedBox(
            height: 16,
          ),
          BlossomText(
            "ทานขนมหวานเป็นประจำ",
            fontWeight: FontWeight.bold,
            size: 18,
          ),
          SizedBox(
            height: 10,
          ),
          BlossomText(
            "${_pre.normalMenstruation ? "เป็นประจำ" : "ไม่ประจำ"}",
            size: 16,
          ),
          SizedBox(
            height: 16,
          ),
          BlossomText(
            "ภาพประกอบ",
            fontWeight: FontWeight.bold,
            size: 18,
          ),
          SizedBox(
            height: 10,
          ),
          _pre.images.isEmpty ? BlossomText("-") : Row(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }

  List<BlossomImage> loadImageFromStorage() {
    return _pre.images.map((e) => BlossomImage(fileStorePath: e,)).toList();
  }
}
