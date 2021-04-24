import 'package:blossom_clinic/model/customer_order_model.dart';
import 'package:blossom_clinic/widget/blossom_circle_avatar.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerOrderItem extends StatelessWidget {
  CustomerOrderModel _customerOrderModel;
  Function(CustomerOrderModel) _listener;

  CustomerOrderItem(this._customerOrderModel, this._listener);

  DateFormat _dateFormat = DateFormat("dd MMMM yyyy", "TH");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 80 * MediaQuery.of(context).size.width / 100,
            child: Row(
              children: [
                BlossomCircleAvatar(
                  30,
                  imageKey: _customerOrderModel.doctorReference.id,
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlossomText(
                        _dateFormat.format(_customerOrderModel.createdAt),
                        size: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      BlossomText(_getStatusDescription(_customerOrderModel.status), size: 12)
                    ],
                  ),
                )),
                ButtonPinkGradient(
                  _getButtonStatus(_customerOrderModel.status),
                  true,
                  () {
                    _listener.call(_customerOrderModel);
                  },
                  radius: 6,
                  height: 32,
                  textSize: 13,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
            height: 1,
            color: Color(0xFF8D8D8D),
          )
        ],
      ),
    );
  }

  String _getStatusDescription(int status) {
    switch (status) {
      case 0:
        return "ชำระเงินเพื่อยืนยันการจอง";
      case 1:
        return "จองเรียบร้อยแล้ว";
      default:
        return "ยกเลิกรายการ";
    }
  }

  String _getButtonStatus(int status) {
    switch (status) {
      case 0:
        return "ชำระเงิน";
      case 1:
        return "สำเร็จ";
      default:
        return "ยกเลิก";
    }
  }
}
