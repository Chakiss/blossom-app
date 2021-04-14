import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/model/user_model.dart';
import 'package:blossom_clinic/page/add_card/add_card_provider.dart';
import 'package:blossom_clinic/widget/add_card_text_field.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/day_and_cvv_section.dart';
import 'package:blossom_clinic/widget/text_field_stroke_dark_pink.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class AddCardPage extends StatefulWidget {
  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  AddCardProvider _provider;
  AddCardTextField _addCardTextField = AddCardTextField();
  TextFieldStrokeDarkPink _nameTextField = TextFieldStrokeDarkPink("ชื่อ - นามสกุล");
  TextFieldStrokeDarkPink _provinceTextField = TextFieldStrokeDarkPink("จังหวัด");
  TextFieldStrokeDarkPink _postalCodeTextField = TextFieldStrokeDarkPink("รหัสไปรษณีย์", maxLength: 5,);
  DayAndCvvSection _dayAndCvvSection;
  String monthExpireData;
  String yearExpireData;
  String cvvData;
  Map<String, String> address;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of(context, listen: false);
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
        safeAreaBottom: false,
        child: Column(
          children: [
            ToolbarBack(title: "เพิ่มการ์ด"),
            Expanded(
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
                      _addCardTextField,
                      Container(margin: EdgeInsets.only(top: 20), child: _dayAndCvvSection),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: BlossomText(
                            "ชื่อที่ปรากฏบนบัตร",
                            size: 15,
                          )),
                      Container(margin: EdgeInsets.only(top: 4), child: _nameTextField),
                      SizedBox(
                        height: 20,
                      ),
                      BlossomText(
                        "จังหวัด",
                        size: 15,
                      ),
                      _provinceTextField,
                      SizedBox(
                        height: 20,
                      ),
                      BlossomText(
                        "รหัสไปรษณีย์",
                        size: 15,
                      ),
                      _postalCodeTextField
                    ],
                  ),
                ),
              ),
            ),
            ButtonPinkGradient(
              "บันทึก",
              true,
              () {
                _provider.callServiceAddCard(
                  context,
                  _nameTextField.getText(),
                  _provinceTextField.getText(),
                  _postalCodeTextField.getText(),
                  _addCardTextField.getText(),
                  cvvData,
                  monthExpireData,
                  yearExpireData
                );
              },
              width: MediaQuery.of(context).size.width,
              radius: 0,
              height: 60,
            )
          ],
        ));
  }
}
