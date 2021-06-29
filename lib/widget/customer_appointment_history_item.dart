import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/network/service_properties.dart';
import 'package:blossom_clinic/page/doctor_order_detail/appointment_history_detail/appointment_history_detail_page.dart';
import 'package:blossom_clinic/usecase/get_shipnity_order_by_invoice_id_use_case.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/text_stroke_pink.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injector/injector.dart';
import 'package:intl/intl.dart';

import 'dialog/blossom_progress_dialog.dart';

class CustomerAppointmentHistoryItem extends StatelessWidget {
  AppointmentModel _appointmentModel;

  CustomerAppointmentHistoryItem(this._appointmentModel, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlossomText(
            "วันที่: ${DateFormat("dd MMMM yyyy", "TH").format(DateFormat("yyyy-MM-dd").parse(_appointmentModel.date))}",
            size: 18,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              TextStrokePink(
                "ข้อมูลก่อนการรักษา",
                () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return AppointmentHistoryDetailPage(_appointmentModel.form.pre);
                  }));
                },
                size: 17,
              ),
              Spacer(),
              TextStrokePink(
                "ผลวินิจฉัย",
                () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return AppointmentHistoryDetailPage(_appointmentModel.form.post);
                  }));
                },
                size: 17,
              ),
              Spacer(),
              TextStrokePink(
                "ยาที่จ่าย",
                () {
                  _getShipnityOrderModelFromReferenceCode(context, _appointmentModel.referenceShipnity);
                },
                size: 17,
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: BlossomTheme.lightGray,
            margin: EdgeInsets.symmetric(vertical: 20),
          ),
          SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }

  Future<void> _getShipnityOrderModelFromReferenceCode(BuildContext context, String referenceCode) async {
    showDialog(barrierDismissible: false, context: context, builder: (BuildContext context) => BlossomProgressDialog());
    GetShipnityOrderByInvoiceIdUseCase useCase = Injector.appInstance.get();
    final result = await useCase.execute({
      "token": ServiceProperties.SHIPNITY_TOKEN,
      "invoiceId": referenceCode
    });
    result.whenWithResult((data) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
        return AppointmentHistoryDetailPage(data);
      }));
    }, (map) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "ไม่พบข้อมูลการจ่ายยาของท่าน",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: BlossomTheme.black,
          textColor: BlossomTheme.white);
    });
  }
}
