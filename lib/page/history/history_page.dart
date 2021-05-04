import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/shipnity_order_model.dart';
import 'package:blossom_clinic/page/history/history_provider.dart';
import 'package:blossom_clinic/page/webview/web_view_page.dart';
import 'package:blossom_clinic/utils/error_handle.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/customer_appointment_item.dart';
import 'package:blossom_clinic/widget/history_segment_control.dart';
import 'package:blossom_clinic/widget/shipnity_order_item.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  HistoryProvider _provider;
  DateFormat _dateFormat = DateFormat("yyyy-MM-dd");
  DateFormat _dateFormatParse = DateFormat("d MMMM yyyy", "TH");
  DateFormat _timeFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateFormat _timeFormatParse = DateFormat("HH:mm");
  ErrorHandle _errorHandle = Injector.appInstance.get();

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.getAppointmentList(context);
    return BaseScreen(
      child: Container(
        child: Column(
          children: [
            Toolbar(
              title: "รายการ",
            ),
            SizedBox(
              height: 26,
            ),
            Center(
                child: HistorySegmentControl(
              (index) {
                _provider.setSelectedIndex(context, index);
              },
              selectedPosition: _provider.selectedIndex,
            )),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Consumer<HistoryProvider>(
                builder: (BuildContext context, HistoryProvider value, Widget child) {
                  if (value.selectedIndex == 0) {
                    return _showAppointmentList(context, value.appointmentList);
                  } else {
                    return _showShipnityOrderList(context, value.orderList);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _showAppointmentList(BuildContext context, List<AppointmentModel> appointmentList) {
    if (appointmentList == null) {
      return Container(
          child: Center(
        child: BlossomProgressIndicator(),
      ));
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: appointmentList?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return CustomerAppointmentItem(appointmentList[index], _dateFormat, _dateFormatParse, _timeFormat,
              _timeFormatParse, Injector.appInstance.get(), Injector.appInstance.get(), (appointment) {
            _goToCallDoctorPage(context, appointment);
          });
        },
      );
    }
  }

  void _goToCallDoctorPage(BuildContext context, AppointmentModel appointment) {
    final timeNow = DateTime.now().millisecondsSinceEpoch;
    final startTime = _timeFormat.parse(appointment.timeStart).millisecondsSinceEpoch;
    final endTime = _timeFormat.parse(appointment.timeEnd).millisecondsSinceEpoch;
    if (timeNow >= startTime && timeNow <= endTime) {
      Navigator.push(context, RouteManager.routeCallDoctor(appointment));
    } else {
      _errorHandle.proceed(context, {"message": "คุณยังไม่ถึงเวลานัดหรือเลยเวลานัด"});
    }
  }

  Widget _showShipnityOrderList(BuildContext context, List<ShipnityOrderModel> orderList) {
    if (orderList == null) {
      return Container(
          child: Center(
        child: BlossomProgressIndicator(),
      ));
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: orderList?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return ShipnityOrderItem(orderList[index], Injector.appInstance.get(), Injector.appInstance.get(),
              (shipnityOrder) {
            goToShipnityOrder(context, shipnityOrder);
          });
        },
      );
    }
  }

  void goToShipnityOrder(BuildContext context, ShipnityOrderModel shipnityOrder) {
    final String url = _extractLinkFromString(shipnityOrder.summary_text);
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return WebViewPage("เลขที่ใบสั่งซื้อ: ${shipnityOrder.invoice_number}", url);
    }));
  }

  String _extractLinkFromString(String text) {
    final regex = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Iterable<RegExpMatch> matches = regex.allMatches(text);
    if (matches.isNotEmpty) {
      return text.substring(matches.first.start, matches.first.end);
    } else {
      return "";
    }
  }
}
