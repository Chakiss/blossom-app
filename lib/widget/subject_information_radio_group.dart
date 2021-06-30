import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class SubjectInformationRadioGroup extends StatefulWidget {
  Function(String) _listener;

  SubjectInformationRadioGroup(this._listener);

  @override
  _SubjectInformationRadioGroupState createState() =>
      _SubjectInformationRadioGroupState();
}

class _SubjectInformationRadioGroupState
    extends State<SubjectInformationRadioGroup> {
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
              Checkbox(
                  value: acneFirst,
                  fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                  onChanged: (bool newValue) {
                    data = addOrRemoveData("สิว");
                    widget._listener.call(data);
                    setState(() {
                      acneFirst = newValue;
                    });
                  }),
              BlossomText(
                "สิว",
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
                    data = addOrRemoveData("ปรับรูปหน้า");
                    widget._listener.call(data);
                    setState(() {
                      acneSecond = newValue;
                    });
                  }),
              BlossomText(
                "ปรับรูปหน้า",
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
                    data = addOrRemoveData("ปรึกษาปัญหาผิวอื่นๆ");
                    widget._listener.call(data);
                    setState(() {
                      acneThird = newValue;
                    });
                  }),
              BlossomText(
                "ปรึกษาปัญหาผิวอื่นๆ",
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
                    data = addOrRemoveData("ติดตามการรักษา");
                    widget._listener.call(data);
                    setState(() {
                      acneForth = newValue;
                    });
                  }),
              BlossomText(
                "ติดตามการรักษา",
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
