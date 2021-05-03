import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class AdviceSelfMultiChoice extends StatefulWidget {
  Function(String) _listener;

  AdviceSelfMultiChoice(this._listener);

  @override
  AdviceSelfMultiChoiceState createState() => AdviceSelfMultiChoiceState();
}

class AdviceSelfMultiChoiceState extends State<AdviceSelfMultiChoice> {

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
                    data = addOrRemoveData("เลี่ยงเครื่องสำอางค์");
                    widget._listener.call(data);
                    setState(() {
                      acneFirst = newValue;
                    });
                  }),
              BlossomText(
                "เลี่ยงเครื่องสำอางค์",
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
                    data = addOrRemoveData("งดนอนดึก");
                    widget._listener.call(data);
                    setState(() {
                      acneSecond = newValue;
                    });
                  }),
              BlossomText(
                "งดนอนดึก",
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
