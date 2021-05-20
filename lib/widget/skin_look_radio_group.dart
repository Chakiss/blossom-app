import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class SkinLookRadioGroup extends StatefulWidget {
  Function(String) _listener;

  SkinLookRadioGroup(this._listener);

  @override
  _SkinLookRadioGroupState createState() => _SkinLookRadioGroupState();
}

class _SkinLookRadioGroupState extends State<SkinLookRadioGroup> {
  String _skinLook = "";

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BlossomTheme.white,
      child: Column(
        children: [
          Row(
            children: [
              Radio<String>(
                fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                value: "1",
                groupValue: _skinLook,
                onChanged: (String value) {
                  widget._listener.call(value);
                  setState(() {
                    _skinLook = value;
                  });
                },
              ),
              BlossomText(
                'ผิวแห้ง',
                size: 15,
              ),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                value: "2",
                groupValue: _skinLook,
                onChanged: (String value) {
                  widget._listener.call(value);
                  setState(() {
                    _skinLook = value;
                  });
                },
              ),
              BlossomText(
                'ผิวมันทั่วใบหน้า',
                size: 15,
              ),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                value: "3",
                groupValue: _skinLook,
                onChanged: (String value) {
                  widget._listener.call(value);
                  setState(() {
                    _skinLook = value;
                  });
                },
              ),
              BlossomText(
                'ผิวผสม, มันเฉพาะ T zone',
                size: 15,
              ),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                value: "4",
                groupValue: _skinLook,
                onChanged: (String value) {
                  widget._listener.call(value);
                  setState(() {
                    _skinLook = value;
                  });
                },
              ),
              BlossomText(
                'ผิวแพ้ง่าย',
                size: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
