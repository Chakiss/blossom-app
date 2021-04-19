import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class AcneLookRadioGroup extends StatefulWidget {
  @override
  _AcneLookRadioGroupState createState() => _AcneLookRadioGroupState();
}

class _AcneLookRadioGroupState extends State<AcneLookRadioGroup> {

  String _acneLook = "";

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
                value: "ผิวแห้ง",
                groupValue: _acneLook,
                onChanged: (String value) {
                  setState(() {
                    _acneLook = value;
                  });
                },
              ),
              BlossomText('ผิวแห้ง', size: 15,),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                value: "ผิวมันทั่วใบหน้า",
                groupValue: _acneLook,
                onChanged: (String value) {
                  setState(() {
                    _acneLook = value;
                  });
                },
              ),
              BlossomText('ผิวมันทั่วใบหน้า', size: 15,),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                value: "ผิวผสม, มันเฉพาะ T zone",
                groupValue: _acneLook,
                onChanged: (String value) {
                  setState(() {
                    _acneLook = value;
                  });
                },
              ),
              BlossomText('ผิวผสม, มันเฉพาะ T zone', size: 15,),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                value: "ผิวแพ้ง่าย",
                groupValue: _acneLook,
                onChanged: (String value) {
                  setState(() {
                    _acneLook = value;
                  });
                },
              ),
              BlossomText('ผิวแพ้ง่าย', size: 15,),
            ],
          ),
        ],
      ),
    );
  }
}
