import 'package:blossom_clinic/model/shipnity_order_model.dart';
import 'package:blossom_clinic/widget/appointment_dispense_item.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class AppointmentDispensePage extends StatelessWidget {
  ShipnityOrderModel _shipnityOrderModel;

  AppointmentDispensePage(this._shipnityOrderModel);

  @override
  Widget build(BuildContext context) {
    return _shipnityOrderModel == null
        ? Container(
            child: Center(
            child: BlossomProgressIndicator(),
          ))
        : SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 7 * MediaQuery.of(context).size.width / 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BlossomText(
                        "เลขที่ใบสั่งซื้อ:",
                        fontWeight: FontWeight.bold,
                        size: 18,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      BlossomText(
                        _shipnityOrderModel.invoice_number,
                        size: 18,
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: _shipnityOrderModel.purchases?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return AppointmentDispenseItem(_shipnityOrderModel.purchases[index], (purchase) {});
                    },
                  )
                ],
              ),
            ),
          );
  }
}
