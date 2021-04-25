import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class AcneDurationInformationRadioGroup extends StatefulWidget {

  Function(String) _listener;

  AcneDurationInformationRadioGroup(this._listener);

  @override
  _AcneDurationInformationRadioGroupState createState() => _AcneDurationInformationRadioGroupState();
}

class _AcneDurationInformationRadioGroupState extends State<AcneDurationInformationRadioGroup> {
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
                "น้อยกว่า 1 เดือน",
                size: 15,
              ),
            ],
          ),
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
                "1 - 6 เดือน",
                size: 15,
              ),
            ],
          ),
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
                "มากกว่า 6 เดือน",
                size: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
