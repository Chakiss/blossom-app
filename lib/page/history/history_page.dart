import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/page/history/history_provider.dart';
import 'package:blossom_clinic/widget/customer_order_item.dart';
import 'package:blossom_clinic/widget/history_segment_control.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {

  HistoryProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.getCustomerOrder(context);
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
            Column(
              children: [
                Center(child: HistorySegmentControl((index) {})),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Consumer<HistoryProvider>(builder: (BuildContext context, HistoryProvider value, Widget child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.customerOrderList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomerOrderItem(value.customerOrderList[index], (customerOrder) {

                        });
                      },
                    );
                  },)
                )
              ],
            ),
            Consumer<HistoryProvider>(builder: (BuildContext context, HistoryProvider value, Widget child) {
              return Container();
            }),
          ],
        ),
      ),
    );
  }
}
