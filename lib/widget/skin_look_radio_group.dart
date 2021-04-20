import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class SkinLookRadioGroup extends StatefulWidget {
  @override
  _SkinLookRadioGroupRadioGroupState createState() => _SkinLookRadioGroupRadioGroupState();
}

class _SkinLookRadioGroupRadioGroupState extends State<SkinLookRadioGroup> {
  String _acneLook = "";

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
                    value: "สิวอุดตัน",
                    groupValue: _acneLook,
                    onChanged: (String value) {
                      setState(() {
                        _acneLook = value;
                      });
                    },
                  ),
                  BlossomText(
                    'สิวอุดตัน',
                    size: 15,
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                    value: "สิวอักเสบ",
                    groupValue: _acneLook,
                    onChanged: (String value) {
                      setState(() {
                        _acneLook = value;
                      });
                    },
                  ),
                  BlossomText(
                    'สิวอักเสบ',
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  Radio<String>(
                    fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                    value: "สิวอักเสบ สัมพันธ์กับรอบเดือน",
                    groupValue: _acneLook,
                    onChanged: (String value) {
                      setState(() {
                        _acneLook = value;
                      });
                    },
                  ),
                  BlossomText(
                    'สิวอักเสบ สัมพันธ์กับรอบเดือน',
                    size: 15,
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                    value: "รอยสิว",
                    groupValue: _acneLook,
                    onChanged: (String value) {
                      setState(() {
                        _acneLook = value;
                      });
                    },
                  ),
                  BlossomText(
                    'รอยสิว',
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  Radio<String>(
                    fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                    value: "หลุมสิว",
                    groupValue: _acneLook,
                    onChanged: (String value) {
                      setState(() {
                        _acneLook = value;
                      });
                    },
                  ),
                  BlossomText(
                    'หลุมสิว',
                    size: 15,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
