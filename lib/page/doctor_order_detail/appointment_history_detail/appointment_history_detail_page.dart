import 'package:blossom_clinic/base/base_screen_second.dart';
import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/shipnity_order_model.dart';
import 'package:blossom_clinic/page/doctor_order_detail/appointment_post_page.dart';
import 'package:blossom_clinic/page/doctor_order_detail/appointment_pre_page.dart';
import 'package:flutter/material.dart';

import '../appointment_dispense_page.dart';

class AppointmentHistoryDetailPage extends StatefulWidget {
  dynamic _appointment;

  AppointmentHistoryDetailPage(this._appointment);

  @override
  _AppointmentHistoryDetailPageState createState() =>
      _AppointmentHistoryDetailPageState();
}

class _AppointmentHistoryDetailPageState
    extends State<AppointmentHistoryDetailPage> {
  String _title = "";
  Widget _content = Container();

  @override
  void initState() {
    super.initState();
    if (widget._appointment is Pre) {
      _title = "ข้อมูลก่อนการรักษา";
      _content = AppointmentPrePage(widget._appointment);
    } else if (widget._appointment is Post) {
      _title = "ผลวินิจฉัย";
      _content = AppointmentPostPage(widget._appointment);
    } else if (widget._appointment is ShipnityOrderModel) {
      _title = "ยาที่จ่าย";
      _content = AppointmentDispensePage(widget._appointment);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenSecond(
      true,
      safeAreaBottom: false,
      title: _title,
      child: SingleChildScrollView(
          child: Container(color: BlossomTheme.white, child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              _content,
            ],
          ))),
    );
  }
}
