import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/model/customer_order_model.dart';
import 'package:blossom_clinic/page/omise/omise_provider.dart';
import 'package:blossom_clinic/widget/add_card_text_field.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/day_and_cvv_section.dart';
import 'package:blossom_clinic/widget/text_field_stroke_dark_pink.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OmisePage extends StatefulWidget {
  CustomerOrderModel _customerOrder;

  OmisePage(this._customerOrder);

  @override
  _OmisePageState createState() => _OmisePageState();
}

class _OmisePageState extends State<OmisePage> {
  OmiseProvider _provider;
  final addCardTextController = TextEditingController();
  final nameTextController = TextEditingController();
  DayAndCvvSection _dayAndCvvSection;
  String monthExpireData;
  String yearExpireData;
  String cvvData;

  @override
  void initState() {
    _provider = Provider.of(context, listen: false);
    _provider.initOmise(widget._customerOrder.orderId);
    _dayAndCvvSection = DayAndCvvSection((value) {
      List<String> data = value.split(" ");
      monthExpireData = data[0];
      yearExpireData = data[1];
      cvvData = data[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          Toolbar(
            title: "ชำระเงิน",
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: 80 * MediaQuery.of(context).size.width / 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      BlossomText(
                        "หมายเลขบัตร",
                        size: 15,
                      ),
                      AddCardTextField(cardTextController: addCardTextController,),
                      SizedBox(
                        height: 20,
                      ),
                      _dayAndCvvSection,
                      SizedBox(
                        height: 20,
                      ),
                      BlossomText(
                        "ชื่อที่ปรากฏบนบัตร",
                        size: 15,
                      ),
                      Container(margin: EdgeInsets.only(top: 4), child: TextFieldStrokeDarkPink("ชื่อ - นามสกุล", textController: nameTextController,)),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
