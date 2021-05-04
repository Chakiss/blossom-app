import 'package:blossom_clinic/page/add_customer_information/add_customer_information_provider.dart';
import 'package:blossom_clinic/widget/acne_information_radio_group.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/customer_information_item.dart';
import 'package:blossom_clinic/widget/dialog/custom_dialog_two_button.dart';
import 'package:blossom_clinic/widget/slider_acne_duration.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:blossom_clinic/widget/true_false_product_radio_group.dart';
import 'package:blossom_clinic/widget/true_false_radio_group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class AddCustomerInformationPage extends StatelessWidget {
  AddCustomerInformationProvider _provider;
  String _orderId;

  AddCustomerInformationPage(this._orderId);

  TextEditingController _changeProductTextEditController = TextEditingController();
  String acnePeriod = "1";
  String acneCared;
  bool isChangeProduct;
  String changeProduct;
  bool isStressed;
  bool sleepDeprivation;
  bool normalMenstruation;
  bool frequencySweet;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: BlossomTheme.white,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Container(
                  width: 100 * MediaQuery.of(context).size.width / 100,
                  child: Image.asset("assets/nav_bar.png"),
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
              ]),
              Container(
                width: 80 * MediaQuery.of(context).size.width / 100,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlossomText(
                        "ระยะเวลาที่เป็นสิว",
                        size: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      // AcneDurationInformationRadioGroup((acneDuration) {}),
                      SliderAcneDuration((value) {
                        acnePeriod = value;
                        print("acnePeriod $acnePeriod");
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      BlossomText(
                        "เคยรักษาสิวมาก่อนหรือไม่",
                        size: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      AcneInformationRadioGroup((value) {
                        acneCared = value;
                        print("acneCared $acneCared");
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      TrueFalseProductRadioGroup("มีเปลี่ยนผลิตภัณฑ์ใหม่หรือไม่?", _changeProductTextEditController,
                          (boolean) {
                        isChangeProduct = boolean;

                      }),
                      SizedBox(
                        height: 20,
                      ),
                      TrueFalseRadioGroup("มีภาวะเครียด", (data) {
                        isStressed = data;
                        print("isStressed $isStressed");
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      TrueFalseRadioGroup("มีภาวะนอนน้อย, นอนดึก", (data) {
                        sleepDeprivation = data;
                        print("sleepDeprivation $sleepDeprivation");
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      TrueFalseRadioGroup("ประจำเดือนมาปกติ", (data) {
                        normalMenstruation = data;
                        print("normalMenstruation $normalMenstruation");
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      TrueFalseRadioGroup("ทานขนม นมเป็นประจำ", (data) {
                        frequencySweet = data;
                        print("frequencySweet $frequencySweet");
                      }),
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
                      Consumer<AddCustomerInformationProvider>(
                        builder: (BuildContext context, AddCustomerInformationProvider value, Widget child) {
                          return Row(
                            children: [
                              CustomerInformationItem(
                                value.listFile[0],
                                isFirstItem: true,
                                listener: () {
                                  _provider.openCamera(0);
                                },
                              ),
                              CustomerInformationItem(
                                value.listFile[1],
                                isFirstItem: false,
                                listener: () {
                                  _provider.openCamera(1);
                                },
                              ),
                              CustomerInformationItem(
                                value.listFile[2],
                                isFirstItem: false,
                                listener: () {
                                  _provider.openCamera(2);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: ButtonPinkGradient(
                            "ยืนยัน",
                            true,
                            () {
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) => CustomDialogTwoButton(
                                  title: "ยืนยัน",
                                  description: "คุณยืนยันการส่งข้อมูลให้ทางแพทย์",
                                  positiveButton: "ยืนยัน",
                                  positiveListener: () async {
                                    Navigator.pop(dialogContext);
                                    _provider.confirmPatientForm(
                                        context,
                                        _orderId,
                                        acnePeriod,
                                        acneCared,
                                        isChangeProduct,
                                        _changeProductTextEditController.text,
                                        isStressed,
                                        sleepDeprivation,
                                        normalMenstruation,
                                        frequencySweet);
                                    // Navigator.pushAndRemoveUntil(
                                    //     context, RouteManager.routeMain(initIndex: 1), (route) => false);
                                  },
                                  negativeButton: "ยกเลิก",
                                  negativeListener: () {
                                    Navigator.pop(dialogContext);
                                  },
                                ),
                              );
                            },
                            width: 40 * MediaQuery.of(context).size.width / 100,
                            radius: 6,
                            padding: EdgeInsets.only(left: 30, right: 30),
                          )),
                      SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
