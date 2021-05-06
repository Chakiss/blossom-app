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
  bool acneFirst = false;
  bool acneSecond = false;
  bool acneThird = false;
  bool acneForth = false;
  bool acneFifth = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BlossomTheme.white,
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                  value: acneFirst,
                  fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                  onChanged: (bool newValue) {
                    _acneLook = addOrRemoveData("1");
                    widget._listener.call(_acneLook);
                    setState(() {
                      acneFirst = newValue;
                    });
                  }),
              BlossomText(
                "สิวอุดตัน",
                size: 15,
              )
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: acneSecond,
                  fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                  onChanged: (bool newValue) {
                    _acneLook = addOrRemoveData("2");
                    widget._listener.call(_acneLook);
                    setState(() {
                      acneSecond = newValue;
                    });
                  }),
              BlossomText(
                "สิวอักเสบ",
                size: 15,
              )
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: acneThird,
                  fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                  onChanged: (bool newValue) {
                    _acneLook = addOrRemoveData("3");
                    widget._listener.call(_acneLook);
                    setState(() {
                      acneThird = newValue;
                    });
                  }),
              BlossomText(
                "สิวอักเสบ สัมพันธ์กับรอบเดือน",
                size: 15,
              )
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: acneForth,
                  fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                  onChanged: (bool newValue) {
                    _acneLook = addOrRemoveData("4");
                    widget._listener.call(_acneLook);
                    setState(() {
                      acneForth = newValue;
                    });
                  }),
              BlossomText(
                "รอยสิว",
                size: 15,
              )
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: acneFifth,
                  fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                  onChanged: (bool newValue) {
                    _acneLook = addOrRemoveData("5");
                    widget._listener.call(_acneLook);
                    setState(() {
                      acneFifth = newValue;
                    });
                  }),
              BlossomText(
                "หลุมสิว",
                size: 15,
              )
            ],
          ),
        ],
      ),
    );
  }

  String addOrRemoveData(String value) {
    if (_acneLook.contains("$value,")) {
      return _acneLook.replaceAll("$value,", "");
    } else {
      return "$_acneLook$value,";
    }
  }
}
