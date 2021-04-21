import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/page/add_customer_information/add_customer_information_page.dart';
import 'package:blossom_clinic/page/add_customer_information/add_customer_information_provider.dart';
import 'package:blossom_clinic/page/confirm_consult/confirm_consult_provider.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class ConfirmConsultPage extends StatelessWidget {
  ConfirmConsultProvider _provider;

  ConfirmConsultPage();

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.callServiceGetDoctorMinConsult(context);
    return BaseScreen(
      safeAreaBottom: true,
      child: Consumer<ConfirmConsultProvider>(
        builder: (BuildContext context, ConfirmConsultProvider value, Widget child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ToolbarBack(
                title: "ยืนยันการจอง",
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Container(
                  width: 80 * MediaQuery.of(context).size.width / 100,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: BlossomText(
                          "ระยะเวลาการปรึกษาแพทย์",
                          color: BlossomTheme.black,
                          size: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      value.doctorDurationChoice != null ? value.doctorDurationChoice : BlossomProgressIndicator(),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        height: 1,
                        color: BlossomTheme.lightGray,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: BlossomText(
                          "เวลาที่ต้องการปรึกษาแพทย์",
                          color: BlossomTheme.black,
                          size: 15,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      value.dateReserveList != null
                          ? GridView.count(
                              shrinkWrap: true,
                              primary: false,
                              padding: const EdgeInsets.all(0.0),
                              crossAxisSpacing: 10.0,
                              crossAxisCount: 4,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 3 / 1.5,
                              children: value.dateReserveList,
                            )
                          : BlossomProgressIndicator(),
                    ],
                  ),
                )),
              ),
              Container(
                height: 1,
                color: BlossomTheme.lightGray,
              ),
              Container(
                width: 80 * MediaQuery.of(context).size.width / 100,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlossomText(
                      "ค่าใช้จ่ายในการปรึกษา x บาท",
                      color: BlossomTheme.black,
                      size: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    ButtonPinkGradient(
                      "ยืนยัน",
                      true,
                      () {
                        _goToCustomerPage(context);
                      },
                      height: 40,
                      radius: 4,
                      padding: EdgeInsets.only(left: 32, right: 32),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  void _goToCustomerPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AddCustomerInformationProvider(),
        )
      ], child: AddCustomerInformationPage());
    }));
  }
}
