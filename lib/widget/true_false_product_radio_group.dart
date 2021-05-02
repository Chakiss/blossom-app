import 'dart:ffi';

import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/text_field_stroke_black.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrueFalseProductRadioGroup extends StatefulWidget {
  String _title;
  TextEditingController _textEditingController;
  Function(bool, String) _listener;

  TrueFalseProductRadioGroup(this._title, this._textEditingController, this._listener);

  @override
  _TrueFalseProductRadioGroupState createState() => _TrueFalseProductRadioGroupState();
}

class _TrueFalseProductRadioGroupState extends State<TrueFalseProductRadioGroup> {
  String _value = "";

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BlossomTheme.white,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: BlossomText(
              widget._title,
              size: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Radio<String>(
                fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                value: "Y",
                groupValue: _value,
                onChanged: (String value) {
                  widget._listener.call(true, "");
                  setState(() {
                    _value = value;
                  });
                },
              ),
              BlossomText(
                "ใช่",
                size: 15,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextFieldStrokeBlack(
                  "",
                  enabled: _value == "Y",
                  textController: widget._textEditingController,
                  width: 42,
                ),
              )
            ],
          ),
          Row(
            children: [
              Radio<String>(
                fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                value: "N",
                groupValue: _value,
                onChanged: (String value) {
                  widget._listener.call(false, "");
                  setState(() {
                    _value = value;
                  });
                },
              ),
              BlossomText(
                "ไม่ใช่",
                size: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
