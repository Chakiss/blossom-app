import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class SkinLookDiagnoseRadioGroup extends StatefulWidget {

  Function(String) _listener;

  SkinLookDiagnoseRadioGroup(this._listener);

  @override
  _SkinLookDiagnoseRadioGroupState createState() => _SkinLookDiagnoseRadioGroupState();
}

class _SkinLookDiagnoseRadioGroupState extends State<SkinLookDiagnoseRadioGroup> {
  String _skinLook = "";

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
                    value: "ผิวแห้ง",
                    groupValue: _skinLook,
                    onChanged: (String value) {
                      widget._listener.call(value);
                      setState(() {
                        _skinLook = value;
                      });
                    },
                  ),
                  BlossomText(
                    "ผิวแห้ง",
                    size: 15,
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                    value: "ผิวมันทั่วใบหน้า",
                    groupValue: _skinLook,
                    onChanged: (String value) {
                      widget._listener.call(value);
                      setState(() {
                        _skinLook = value;
                      });
                    },
                  ),
                  BlossomText(
                    "ผิวมันทั่วใบหน้า",
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
                    value: "ผิวผสม, มันเฉพาะ T zone",
                    groupValue: _skinLook,
                    onChanged: (String value) {
                      widget._listener.call(value);
                      setState(() {
                        _skinLook = value;
                      });
                    },
                  ),
                  BlossomText(
                    "ผิวผสม, มันเฉพาะ T zone",
                    size: 15,
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                    value: "ผิวแพ้ง่าย",
                    groupValue: _skinLook,
                    onChanged: (String value) {
                      widget._listener.call(value);
                      setState(() {
                        _skinLook = value;
                      });
                    },
                  ),
                  BlossomText(
                    "ผิวแพ้ง่าย",
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
