import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/page/doctor_order_detail/appointment_post_page.dart';
import 'package:blossom_clinic/page/doctor_order_detail/doctor_appointment_detail_provider.dart';
import 'package:blossom_clinic/widget/appointment_detail_segment_control.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appointment_pre_page.dart';

class DoctorAppointmentDetailPage extends StatelessWidget {
  AppointmentModel _appointmentModel;
  String _name;
  String _appointmentTime;

  DoctorAppointmentDetailPage(this._appointmentModel, this._name, this._appointmentTime);

  DoctorAppointmentDetailProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.initialPage(_appointmentModel);
    return BaseScreen(
      child: Column(
        children: [
          ToolbarBack(
            title: _name,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10 * MediaQuery.of(context).size.width / 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 28,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlossomText(
                          _name,
                          size: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        BlossomText("อายุ xx ปี", size: 18, fontWeight: FontWeight.bold)
                      ],
                    ),
                    Spacer(),
                    Container(
                      child: ButtonPinkGradient(
                        "โทร",
                        true,
                        () {},
                        radius: 6,
                        height: 32,
                      ),
                    )
                  ],
                ),
                BlossomText("เวลานัด $_appointmentTime", size: 18, fontWeight: FontWeight.bold),
              ],
            ),
          ),
          SizedBox(
            height: 6 * MediaQuery.of(context).size.height / 100,
          ),
          AppointmentDetailSegmentControl((index) {
            switch (index) {
              case 0:
                _provider.setPage(AppointmentPrePage(_appointmentModel.form.pre));
                break;
              case 1:
                _provider.setPage(AppointmentPostPage(_appointmentModel.form.post));
                break;
            }
          }),
          SizedBox(
            height: 20,
          ),
          Expanded(child: Consumer<DoctorAppointmentDetailProvider>(
            builder: (BuildContext context, DoctorAppointmentDetailProvider value, Widget child) {
              if (value.page == null) {
                return Container();
              } else {
                return value.page;
              }
            },
          )),
        ],
      ),
    );
  }
}
