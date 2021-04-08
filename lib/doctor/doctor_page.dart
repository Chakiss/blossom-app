import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class DoctorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlossomText(
                    "พบแพทย์",
                    color: BlossomTheme.white,
                    size: 36,
                    fontWeight: FontWeight.bold,
                  ),
                  BlossomText("สวัสดี xxxxx xxxxxxxxxx", color: BlossomTheme.white, size: 20,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
