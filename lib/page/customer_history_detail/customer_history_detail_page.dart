import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/page/customer_history_detail/customer_history_post_page.dart';
import 'package:blossom_clinic/page/customer_history_detail/doctor_appointment_detail_provider.dart';
import 'package:blossom_clinic/widget/appointment_detail_segment_control.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blossom_theme.dart';
import 'customer_history_dispense_page.dart';
import 'customer_history_pre_page.dart';

class CustomerHistoryDetailPage extends StatefulWidget {
  AppointmentModel _appointmentModel;
  String _name;
  String _appointmentTime;

  CustomerHistoryDetailPage(this._appointmentModel, this._name, this._appointmentTime);

  @override
  _CustomerHistoryDetailPageState createState() => _CustomerHistoryDetailPageState();
}

class _CustomerHistoryDetailPageState extends State<CustomerHistoryDetailPage> {
  CustomerHistoryDetailProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.initialPage(widget._appointmentModel);
    _provider.callServiceGetShipnityOrderByInvoiceId(widget._appointmentModel.referenceShipnity);
    _provider.callServiceGetUserProfileById(widget._appointmentModel);
    return Consumer<CustomerHistoryDetailProvider>(
        builder: (BuildContext context, CustomerHistoryDetailProvider value, Widget child) {
          return Scaffold(
              backgroundColor: BlossomTheme.white,
              body: Column(children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 100 * MediaQuery.of(context).size.width / 100,
                        child: Image.asset("assets/nav_bar.png"),
                      ),
                    ),
                    SafeArea(
                        child: ToolbarBack(
                          title: widget._name,
                        )),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7 * MediaQuery.of(context).size.width / 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                SizedBox(
                  height: 4 * MediaQuery.of(context).size.height / 100,
                ),
                AppointmentDetailSegmentControl((index) {
                  switch (index) {
                    case 0:
                      _provider.setPage(CustomerHistoryPrePage(widget._appointmentModel.form.pre));
                      break;
                    case 1:
                      _provider.setPage(CustomerHistoryPostPage(widget._appointmentModel.form.post));
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
                        _provider.setPage(CustomerHistoryDispensePage(_provider.shipnityOrderModel));
                      }
                      break;
                  }
                }),
                SizedBox(
                  height: 20,
                ),
                Expanded(child: value.page == null ? Container() : value.page),
              ]));
        });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
