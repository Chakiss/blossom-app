
import 'package:blossom_clinic/model/date_reserve_model.dart';
import 'package:blossom_clinic/model/doctor_time_model.dart';
import 'package:blossom_clinic/model/response/doctor_info.dart';
import 'package:blossom_clinic/model/response/get_doctor_min_consult_response_model.dart';
import 'package:blossom_clinic/page/add_customer_information/add_customer_information_provider.dart';
import 'package:blossom_clinic/widget/acne_look_radio_group.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/customer_information_item.dart';
import 'package:blossom_clinic/widget/dialog/custom_dialog_two_button.dart';
import 'package:blossom_clinic/widget/text_field_stroke_black.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class AddCustomerInformationPage extends StatelessWidget {

  var _symptomTextController = TextEditingController();
  AddCustomerInformationProvider _provider;
  DoctorInfo _doctorInfo;
  GetDoctorMinConsultResponseModel _doctorMin;
  DoctorTimeModel _doctorTimeModel;
  DateReserveModel _dateReserveModel;


  AddCustomerInformationPage(this._doctorInfo, this._doctorMin,
      this._doctorTimeModel, this._dateReserveModel);

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: BlossomTheme.white,
        ),
        Column(
          children: [
            Container(
              width: 100 * MediaQuery.of(context).size.width / 100,
              child: Image.asset("assets/nav_bar.png"),
            ),
            Container(
              width: 80 * MediaQuery.of(context).size.width / 100,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlossomText(
                      "ลักษณะผิว",
                      size: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    AcneLookRadioGroup(),
                    SizedBox(
                      height: 20,
                    ),
                    BlossomText(
                      "ลักษณะสิว",
                      size: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlossomText(
                      "รูป",
                      size: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Consumer<AddCustomerInformationProvider>(builder: (BuildContext context, AddCustomerInformationProvider value, Widget child) {
                      return Row(
                        children: [
                          CustomerInformationItem(value.listFile[0], isFirstItem: true, listener: () {
                            _provider.openCamera(0);
                          },),
                          CustomerInformationItem(value.listFile[1], isFirstItem: false, listener: () {
                            _provider.openCamera(1);
                          },),
                          CustomerInformationItem(value.listFile[2], isFirstItem: false, listener: () {
                            _provider.openCamera(2);
                          },),
                        ],
                      );
                    },),
                    SizedBox(
                      height: 32,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: ButtonPinkGradient(
                          "ยืนยัน",
                          true,
                          () {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) => CustomDialogTwoButton(
                                title: "ยืนยันการจอง",
                                description: "คุณต้องการจองการปรึกษาแพทย์ ${_doctorInfo?.profileTitle ?? ""} " +
                                    "ในวันที่ ${DateFormat("d MMMM yyyy", "TH").format(DateTime.parse(_dateReserveModel.date))} " +
                                    "เวลา ${_doctorTimeModel?.start ?? ""} ${_doctorTimeModel?.unit ?? "น."} " +
                                    "เป็นเวลา ${_doctorMin.quota} นาที",
                                positiveButton: "ยืนยัน",
                                positiveListener: () async {
                                  Navigator.pop(dialogContext);
                                  await _provider.confirmConsult(context, _doctorInfo, _doctorMin, _doctorTimeModel, _dateReserveModel);
                                  // _provider.openWebViewUrl(context, "Omise", null);
                                },
                                negativeButton: "ยกเลิก", negativeListener: () {
                                Navigator.pop(dialogContext);
                              },),
                            );
                          },
                          radius: 4,
                          padding: EdgeInsets.only(left: 30, right: 30),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
        SafeArea(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Toolbar(
              title: "ข้อมูลประกอบการศึกษา",
            ),
          ],
        ))
      ],
    );
  }
}
