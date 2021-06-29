import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/page/doctor_order_detail/appointment_customer_data_page.dart';
import 'package:blossom_clinic/page/doctor_order_detail/appointment_dispense_page.dart';
import 'package:blossom_clinic/page/doctor_order_detail/appointment_post_page.dart';
import 'package:blossom_clinic/page/doctor_order_detail/doctor_appointment_detail_provider.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/widget/appointment_detail_segment_control.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/dialog/call_type_dialog.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';
import 'appointment_pre_page.dart';

class DoctorAppointmentDetailPage extends StatefulWidget {
  AppointmentModel _appointmentModel;
  String _name;
  String _appointmentTime;

  DoctorAppointmentDetailPage(this._appointmentModel, this._name, this._appointmentTime);

  @override
  _DoctorAppointmentDetailPageState createState() => _DoctorAppointmentDetailPageState();
}

class _DoctorAppointmentDetailPageState extends State<DoctorAppointmentDetailPage> {
  DoctorAppointmentDetailProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.initialPage(widget._appointmentModel);
    _provider.callServiceGetShipnityOrderByInvoiceId(widget._appointmentModel.referenceShipnity);
    _provider.callServiceGetUserProfileById(widget._appointmentModel);
    return Consumer<DoctorAppointmentDetailProvider>(
        builder: (BuildContext context, DoctorAppointmentDetailProvider value, Widget child) {
      return Scaffold(
          backgroundColor: BlossomTheme.darkPink,
          body: Column(children: [
            Stack(
              children: [
                // Align(
                //   alignment: Alignment.topCenter,
                //   child: Container(
                //     width: 100 * MediaQuery.of(context).size.width / 100,
                //     child: Image.asset("assets/nav_bar.png"),
                //   ),
                // ),
                SafeArea(
                    child: ToolbarBack(
                  title: widget._name,
                )),
              ],
            ),
            Container(
              color: BlossomTheme.white,
              padding: EdgeInsets.symmetric(horizontal: 7 * MediaQuery.of(context).size.width / 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlossomText(
                            widget._name,
                            size: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          Row(
                            children: [
                              BlossomText("อายุ : ", size: 18, fontWeight: FontWeight.bold),
                              BlossomText("${_provider.age} ปี", size: 18)
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Container(
                        child: ButtonPinkGradient(
                          "ติดต่อ",
                          true,
                          () {
                            // _launchURL("tel:${_provider.tel}");
                            _showCallTypeDialog(context, "tel:${_provider.tel}");
                          },
                          radius: 6,
                          height: 32,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BlossomText("เวลานัด : ", size: 18, fontWeight: FontWeight.bold),
                      BlossomText("${widget._appointmentTime}", size: 18),
                    ],
                  )
                ],
              ),
            ),
            Container(
              color: BlossomTheme.white,
              height: 4 * MediaQuery.of(context).size.height / 100,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: BlossomTheme.white,
              child: Center(
                child: AppointmentDetailSegmentControl((index) {
                  switch (index) {
                    case 0:
                      _provider.setPage(AppointmentCustomerDataPage());
                      break;
                    case 1:
                      _provider.setPage(AppointmentPostPage(widget._appointmentModel.form.post));
                      break;
                    case 2:
                      if (widget._appointmentModel.referenceShipnity?.isEmpty ?? true) {
                        _provider.setPage(Container(
                          child: Center(
                            child: BlossomText(
                              "ไม่พบข้อมูลสั่งยา",
                              size: 20,
                            ),
                          ),
                        ));
                      } else {
                        _provider.setPage(AppointmentDispensePage(_provider.shipnityOrderModel));
                      }
                      break;
                  }
                }),
              ),
            ),
            Container(
              color: BlossomTheme.white,
              height: 20,
            ),
            Expanded(child: Container(color: BlossomTheme.white, child: value.page == null ? Container() : value.page)),
          ]));
    });
  }

  void _goToChatPage(BuildContext context, AppointmentModel appointmentModel) {
    Navigator.push(context, RouteManager.routeDoctorChat(appointmentModel));
  }

  void _showCallTypeDialog(BuildContext context, String url) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: BlossomText(
          "เลือกประเภทการโทร",
          textAlign: TextAlign.center,
          size: 22,
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: BlossomText(
              "แชท",
              textAlign: TextAlign.center,
              size: 20,
              color: BlossomTheme.darkPink,
            ),
            onPressed: () {
              Navigator.pop(context);
              _goToChatPage(context, widget._appointmentModel);
            },
          ),
          CupertinoActionSheetAction(
            child: BlossomText(
              "โทร",
              textAlign: TextAlign.center,
              size: 20,
              color: BlossomTheme.darkPink,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, RouteManager.routeVoiceCallCustomer(widget._appointmentModel));
            },
          ),
          CupertinoActionSheetAction(
            child: BlossomText(
              "วีดีโอ",
              textAlign: TextAlign.center,
              size: 20,
              color: BlossomTheme.darkPink,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, RouteManager.routeDoctorCallCustomer(widget._appointmentModel));
            },
          ),
          CupertinoActionSheetAction(
            child: BlossomText(
              "ยกเลิก",
              textAlign: TextAlign.center,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
    // showDialog(
    //   context: context,
    //   builder: (BuildContext dialogContext) {
    //     return CallTypeDialog((type) {
    //       Navigator.pop(context);
    //       if (type == 0) {
    //         _goToChatPage(context, widget._appointmentModel);
    //       } else if (type == 1) {
    //         Navigator.push(context, RouteManager.routeVoiceCallCustomer(widget._appointmentModel));
    //       } else {
    //         Navigator.push(context, RouteManager.routeDoctorCallCustomer(widget._appointmentModel));
    //       }
    //     });
    //   },
    // );
  }
}
