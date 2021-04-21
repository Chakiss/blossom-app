import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class AcneLookRadioGroup extends StatefulWidget {

  Function(String) _listener;

  AcneLookRadioGroup(this._listener);

  @override
  AcneLookGroupRadioGroupState createState() => AcneLookGroupRadioGroupState();
}

class AcneLookGroupRadioGroupState extends State<AcneLookRadioGroup> {
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
                    value: "1",
                    groupValue: _acneLook,
                    onChanged: (String value) {
                      widget._listener.call(value);
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
                    value: "2",
                    groupValue: _acneLook,
                    onChanged: (String value) {
                      widget._listener.call(value);
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
                    value: "3",
                    groupValue: _acneLook,
                    onChanged: (String value) {
                      widget._listener.call(value);
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
                    value: "4",
                    groupValue: _acneLook,
                    onChanged: (String value) {
                      widget._listener.call(value);
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
                    value: "5",
                    groupValue: _acneLook,
                    onChanged: (String value) {
                      widget._listener.call(value);
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
