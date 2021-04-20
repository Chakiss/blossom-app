import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/text_field_stroke_black.dart';
import 'package:flutter/material.dart';

class DrugAllergy extends StatefulWidget {

  TextEditingController _textEditingController;

  DrugAllergy(this._textEditingController);

  @override
  _DrugAllergyState createState() => _DrugAllergyState();
}

class _DrugAllergyState extends State<DrugAllergy> {
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
                    value: "ใช่",
                    groupValue: _value,
                    onChanged: (String value) {
                      setState(() {
                        _value = value;
                        enable = true;
                      });
                    },
                  ),
                  BlossomText(
                    'ใช่',
                    size: 15,
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                    value: "ไม่ใช่",
                    groupValue: _value,
                    onChanged: (String value) {
                      setState(() {
                        _value = value;
                        enable = false;
                      });
                    },
                  ),
                  BlossomText(
                    'ไม่ใช่',
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
          TextFieldStrokeBlack("", enabled: enable, textController: widget._textEditingController,)
        ],
      ),
    );
  }
}
