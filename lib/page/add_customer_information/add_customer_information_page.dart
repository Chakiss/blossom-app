import 'package:blossom_clinic/page/add_customer_information/add_customer_information_provider.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/customer_information_item.dart';
import 'package:blossom_clinic/widget/text_field_stroke_black.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class AddCustomerInformationPage extends StatelessWidget {
  var symptomTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: BlossomTheme.white,
        ),
        Column(
          children: [
            Container(
              width: 100 * MediaQuery.of(context).size.width / 100,
              child: Image.asset("assets/nav_bar.png"),
            ),
            Container(
              width: 80 * MediaQuery.of(context).size.width / 100,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlossomText(
                      "อาการเบื้องต้น",
                      size: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AspectRatio(
                        aspectRatio: 2 / 1.5,
                        child: TextFieldStrokeBlack(
                          "ตัวอย่าง ... สิวบริเวณคางเยอะมากเลยค่ะ",
                          textAlignVertical: TextAlignVertical.top,
                          maxLength: 200,
                          textEditingController: symptomTextController,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    BlossomText(
                      "รูป",
                      size: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        CustomerInformationItem(isFirstItem: true,),
                        CustomerInformationItem(isFirstItem: false,),
                        CustomerInformationItem(isFirstItem: false,),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: ButtonPinkGradient(
                          "ยืนยัน",
                          true,
                          () {},
                          radius: 4,
                          padding: EdgeInsets.only(left: 30, right: 30),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
        SafeArea(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Toolbar(
              title: "ข้อมูลประกอบการศึกษา",
            ),
          ],
        ))
      ],
    );
  }
}
