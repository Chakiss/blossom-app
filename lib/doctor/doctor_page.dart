import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/doctor/doctor_provider.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorPage extends StatelessWidget {
  DoctorProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context, listen: false);
    provider.callServiceGetDoctorList();
    return BaseScreen(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlossomText(
                    "พบแพทย์",
                    color: BlossomTheme.white,
                    size: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  BlossomText(
                    "สวัสดี xxxxx xxxxxxxxxx",
                    color: BlossomTheme.white,
                    size: 16,
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
            ),
            Expanded(child: Container(
              child: Consumer<DoctorProvider>(
                builder: (BuildContext context, DoctorProvider value, Widget child) {
                  return ListView.builder(
                      itemCount: value.doctorList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                DoctorCard(value.doctorList[index]),
                                Container(
                                  margin: EdgeInsets.only(left: 30, right: 30),
                                  height: 1,
                                  color: Color(0xFF8D8D8D),
                                )
                              ],
                            ),
                        );
                      });
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
