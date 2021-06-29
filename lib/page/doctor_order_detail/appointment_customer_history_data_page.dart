import 'package:blossom_clinic/page/doctor_order_detail/appointment_customer_history_data_provider.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/customer_appointment_history_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentCustomerHistoryDataPage extends StatefulWidget {
  AppointmentCustomerHistoryDataPage({Key key}) : super(key: key);

  @override
  _AppointmentCustomerHistoryDataPageState createState() =>
      _AppointmentCustomerHistoryDataPageState();
}

class _AppointmentCustomerHistoryDataPageState
    extends State<AppointmentCustomerHistoryDataPage> {
  AppointmentCustomerHistoryDataProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of(context, listen: false);
    _provider.getAppointmentListByUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentCustomerHistoryDataProvider>(
      builder: (BuildContext context,
          AppointmentCustomerHistoryDataProvider value, Widget child) {
        if (value.isFirstTime) {
          return BlossomProgressIndicator();
        } else {
          if (value.appointmentList == null || value.appointmentList.isEmpty) {
            return Container(
                child: Center(
              child: BlossomText(
                "ไม่พบประวัติการรักษา",
                fontWeight: FontWeight.bold,
                size: 18,
              ),
            ));
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                  horizontal: 7 * MediaQuery.of(context).size.width / 100),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: value.appointmentList?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return CustomerAppointmentHistoryItem(
                      value.appointmentList[index]);
                },
              ),
            );
          }
        }
      },
    );
  }
}
