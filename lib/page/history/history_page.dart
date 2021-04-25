import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/model/customer_order_model.dart';
import 'package:blossom_clinic/page/history/history_provider.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/widget/customer_order_item.dart';
import 'package:blossom_clinic/widget/history_segment_control.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
            Center(child: HistorySegmentControl((index) {})),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Consumer<HistoryProvider>(builder: (BuildContext context, HistoryProvider value, Widget child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.customerOrderList?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomerOrderItem(value.customerOrderList[index], (customerOrder) {
                      if (customerOrder.status == 0) {
                        _goToOmisePage(context, customerOrder);
                      } else if (customerOrder.status == 1) {

                      }
                    });
                  },
                );
              },),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _goToOmisePage(BuildContext context, CustomerOrderModel customerOrder) async {
    Navigator.push(context, RouteManager.routeOmise(customerOrder.orderId, customerOrder.total));
  }
}
