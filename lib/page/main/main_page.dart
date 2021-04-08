import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/doctor/doctor_page.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          child: Column(
            children: [
              Expanded(child: DoctorPage()),
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: BlossomTheme.blackAlpha,
                    blurRadius: 10.0,
                  )
                ]),
                height: 80,
                child: Container(
                  color: BlossomTheme.white,
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          GestureDetector(behavior: HitTestBehavior.opaque, onTap: () {}, child: BlossomText("พบแพทย์"))
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [BlossomText("พบแพทย์")],
                      )),
                      Expanded(
                          child: Column(
                        children: [BlossomText("พบแพทย์")],
                      )),
                      Expanded(
                          child: Column(
                        children: [BlossomText("พบแพทย์")],
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
