import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/text_field_stroke_black.dart';
import 'package:flutter/material.dart';

class AcneTreat extends StatefulWidget {
  @override
  _AcneTreatState createState() => _AcneTreatState();
}

class _AcneTreatState extends State<AcneTreat> {
  String _value = "";
  bool enable = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BlossomTheme.white,
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Radio<String>(
                    fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                    value: "เคย",
                    groupValue: _value,
                    onChanged: (String value) {
                      setState(() {
                        _value = value;
                        enable = true;
                      });
                    },
                  ),
                  BlossomText(
                    'เคย',
                    size: 15,
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                    value: "ไม่เคย",
                    groupValue: _value,
                    onChanged: (String value) {
                      setState(() {
                        _value = value;
                        enable = false;
                      });
                    },
                  ),
                  BlossomText(
                    'ไม่เคย',
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              BlossomText(
                "ถ้าเคย รักษาด้วยวิธีไหน",
                size: 16,
                color: BlossomTheme.black,
              ),
            ],
          ),
          TextFieldStrokeBlack("", enabled: enable,)
        ],
      ),
    );
  }
}
