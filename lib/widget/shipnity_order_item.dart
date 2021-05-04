import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/shipnity_order_model.dart';
import 'package:blossom_clinic/usecase/get_doctor_profile_by_id_use_case.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';

import '../blossom_theme.dart';
import 'blossom_text.dart';

class ShipnityOrderItem extends StatefulWidget {
  ShipnityOrderModel _shipnityOrderModel;
  GetDoctorProfileByIdUseCase _getDoctorProfileByIdUseCase;
  SharedPrefUtils _sharedPrefUtils;
  Function(ShipnityOrderModel) _listener;

  ShipnityOrderItem(this._shipnityOrderModel, this._sharedPrefUtils, this._getDoctorProfileByIdUseCase, this._listener);

  @override
  _ShipnityOrderItemState createState() => _ShipnityOrderItemState();
}

class _ShipnityOrderItemState extends State<ShipnityOrderItem> {

  String doctorName;

  @override
  void initState() {
    super.initState();
    if (widget._sharedPrefUtils.getMapDoctorReference().containsKey(widget._shipnityOrderModel.annotation)) {
     doctorName =  widget._sharedPrefUtils.getMapDoctorReference()[widget._shipnityOrderModel.annotation];
    } else {
      _getDoctorNameByAnnotation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BlossomTheme.white,
      child: InkWell(
        onTap: () {
          widget._listener.call(widget._shipnityOrderModel);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8 * MediaQuery.of(context).size.width / 100, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: BlossomText(
                                "เลขที่ใบสั่งซื้อ: ${widget._shipnityOrderModel.invoice_number}",
                                size: 15,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            width: 12,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: BlossomText(
                                "ยอดรวม ${widget._shipnityOrderModel.price} บาท",
                                size: 14,
                              ))
                        ],
                      ),
                      BlossomText(
                        "แพทย์ที่สั่ง: ${doctorName ?? ""}",
                        size: 14,
                      ),
                      Row(
                        children: [
                          BlossomText(
                            "สถานะ:",
                            size: 14,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          BlossomText(
                            "${widget._shipnityOrderModel.paid ? "ชำระเงินแล้ว" : "รอชำระเงิน"}",
                            size: 14,
                            color: widget._shipnityOrderModel.paid ? BlossomTheme.green : BlossomTheme.gray,
                          )
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.navigate_next,
                      color: BlossomTheme.darkPink,
                      size: 26,
                    ),
                  )
                ],
              ),
              Container(
                color: BlossomTheme.black,
                margin: EdgeInsets.only(top: 12),
                height: 1,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getDoctorNameByAnnotation() async {
    final result = await widget._getDoctorProfileByIdUseCase.execute(widget._shipnityOrderModel.annotation);
    if (result is Success<String>) {
      setState(() {
        doctorName = result.data;
      });
    }
  }
}
