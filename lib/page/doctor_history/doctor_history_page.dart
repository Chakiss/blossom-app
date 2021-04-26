import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/page/doctor_history/doctor_history_provider.dart';
import 'package:blossom_clinic/widget/doctor_history_segment_control.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorHistoryPage extends StatelessWidget {

  DoctorHistoryProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
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
            DoctorHistorySegmentControl((index) {}),
            Consumer<DoctorHistoryProvider>(builder: (BuildContext context, DoctorHistoryProvider value, Widget child) {
              return Container();
            },)
          ],
        ),
      ),
    );
  }
}
