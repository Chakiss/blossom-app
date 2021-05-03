import 'package:blossom_clinic/model/shipnity_order_model.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:flutter/material.dart';

class AppointmentDispensePage extends StatelessWidget {
  ShipnityOrderModel _shipnityOrderModel;

  AppointmentDispensePage(this._shipnityOrderModel);

  @override
  Widget build(BuildContext context) {
    return _shipnityOrderModel == null ? Container(
        child: Center(
          child: BlossomProgressIndicator(),
        )) : SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 7 * MediaQuery.of(context).size.width / 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.builder(
              itemCount: _shipnityOrderModel.purchases?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {

            },)
          ],
        ),
      ),
    );
  }
}
