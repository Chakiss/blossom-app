import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class AcneInformationRadioGroup extends StatefulWidget {
  Function(String) _listener;

  AcneInformationRadioGroup(this._listener);

  @override
  _AcneInformationRadioGroupState createState() => _AcneInformationRadioGroupState();
}

class _AcneInformationRadioGroupState extends State<AcneInformationRadioGroup> {

  String _acneLook;
  String data = "";
  var acneFirst = false;
  var acneSecond = false;
  var acneThird = false;
  var acneForth = false;
  var acneFifth = false;

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
                  data = "";
                  widget._listener.call(data);
                  setState(() {
                    acneFirst = false;
                    acneSecond = false;
                    acneThird = false;
                    acneForth = false;
                    acneFifth = false;
                    _acneLook = value;
                  });
                },
              ),
              BlossomText(
                "ไม่เคย",
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
                  setState(() {
                    _acneLook = value;
                  });
                },
              ),
              BlossomText(
                "เคย",
                size: 15,
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
                margin: EdgeInsets.only(left: 10 * MediaQuery.of(context).size.width / 100),
                child: BlossomText(
                  "ถ้าเคยรักษายังไง? (ตอบได้มากกว่า 1 ข้อ)",
                  size: 15,
                )),
          ),
          Row(
            children: [
              SizedBox(width: 10 * MediaQuery.of(context).size.width / 100,),
              Checkbox(
                  value: acneFirst,
                  fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                  onChanged: _acneLook == "1" ? null : (bool newValue) {
                    data = addOrRemoveData("ใช้ยาคลีนิก");
                    widget._listener.call(data);
                    setState(() {
                      _acneLook = "2";
                      acneFirst = newValue;
                    });
                  }),
              BlossomText(
                "ใช้ยาคลีนิก",
                size: 15,
              )
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10 * MediaQuery.of(context).size.width / 100,),
              Checkbox(
                  value: acneSecond,
                  fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                  onChanged: _acneLook == "1" ? null : (bool newValue) {
                    data = addOrRemoveData("ซื้อยาใช้เอง");
                    widget._listener.call(data);
                    setState(() {
                      _acneLook = "2";
                      acneSecond = newValue;
                    });
                  }),
              BlossomText(
                "ซื้อยาใช้เอง",
                size: 15,
              )
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10 * MediaQuery.of(context).size.width / 100,),
              Checkbox(
                  value: acneThird,
                  fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                  onChanged: _acneLook == "1" ? null : (bool newValue) {
                    data = addOrRemoveData("ซื้อครีมทั่วไปในการรักษาสิว");
                    widget._listener.call(data);
                    setState(() {
                      _acneLook = "2";
                      acneThird = newValue;
                    });
                  }),
              BlossomText(
                "ซื้อครีมทั่วไปในการรักษาสิว",
                size: 15,
              )
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10 * MediaQuery.of(context).size.width / 100,),
              Checkbox(
                  value: acneForth,
                  fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                  onChanged: _acneLook == "1" ? null : (bool newValue) {
                    data = addOrRemoveData("Treatment, กดสิว, ฉีดสิว");
                    widget._listener.call(data);
                    setState(() {
                      _acneLook = "2";
                      acneForth = newValue;
                    });
                  }),
              BlossomText(
                "Treatment, กดสิว, ฉีดสิว",
                size: 15,
              )
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10 * MediaQuery.of(context).size.width / 100,),
              Checkbox(
                  value: acneFifth,
                  fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                  onChanged: _acneLook == "1" ? null : (bool newValue) {
                    data = addOrRemoveData("Laser");
                    widget._listener.call(data);
                    setState(() {
                      _acneLook = "2";
                      acneFifth = newValue;
                    });
                  }),
              BlossomText(
                "Laser",
                size: 15,
              )
            ],
          ),
        ],
      ),
    );
  }

  String addOrRemoveData(String value) {
    if (data.contains("$value, ")) {
      return data.replaceAll("$value, ", "");
    } else {
      return "$data$value, ";
    }
  }
}
