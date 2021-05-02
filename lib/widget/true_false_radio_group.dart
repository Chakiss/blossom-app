import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class TrueFalseRadioGroup extends StatefulWidget {

  String _title;
  Function(bool) _listener;

  TrueFalseRadioGroup(this._title, this._listener);

  @override
  _TrueFalseRadioGroupState createState() => _TrueFalseRadioGroupState();
}

class _TrueFalseRadioGroupState extends State<TrueFalseRadioGroup> {
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
                  widget._listener.call(true);
                  setState(() {
                    _value = value;
                  });
                },
              ),
              BlossomText(
                "ใช่",
                size: 15,
              ),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                value: "N",
                groupValue: _value,
                onChanged: (String value) {
                  widget._listener.call(false);
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
