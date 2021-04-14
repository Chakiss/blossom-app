import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/model/response/get_book_history_response_model.dart';
import 'package:blossom_clinic/page/call_doctor/call_doctor_page.dart';
import 'package:blossom_clinic/page/call_doctor/call_doctor_provider.dart';
import 'package:blossom_clinic/page/history/history_provider.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/history_item.dart';
import 'package:blossom_clinic/widget/history_segment_control.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  HistoryProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.callServiceGetBookingHistory();
    return BaseScreen(
      child: Container(
        child: Column(
          children: [
            Toolbar(
              title: "ประวัติ",
            ),
            SizedBox(
              height: 26,
            ),
            Consumer<HistoryProvider>(
              builder: (BuildContext context, HistoryProvider value, Widget child) {
                return value.bookingList == null
                    ? Expanded(
                        child: Center(
                            child: BlossomText(
                        "กรุณาเข้าสู่ระบบเพื่อใช้งานฟังก์ชั่นนี้",
                        size: 18,
                      )))
                    : Column(
                        children: [
                          Center(child: HistorySegmentControl((index) {})),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: value.bookingList?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return HistoryItem(value.bookingList[index], (historyResponseModel) {
                                  _callToDoctor(context, historyResponseModel);
                                });
                              },
                            ),
                          )
                        ],
                      );
              },
            )
          ],
        ),
      ),
    );
  }

  void _callToDoctor(BuildContext context, GetBookingHistoryResponseModel historyResponseModel) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) =>
              CallDoctorProvider(Injector.appInstance.get(), Injector.appInstance.get(), historyResponseModel),
        )
      ],
      child: CallDoctorPage(),);
    }));
  }
}
