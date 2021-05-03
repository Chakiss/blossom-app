import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class DiagnoseMultiCheckBox extends StatefulWidget {
  Function(String) _listener;

  DiagnoseMultiCheckBox(this._listener);

  @override
  _DiagnoseMultiCheckBoxState createState() => _DiagnoseMultiCheckBoxState();
}

class _DiagnoseMultiCheckBoxState extends State<DiagnoseMultiCheckBox> {

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
                    data = addOrRemoveData("สิวระดับอ่อน");
                    widget._listener.call(data);
                    setState(() {
                      acneFirst = newValue;
                    });
                  }),
              BlossomText(
                "สิวระดับอ่อน",
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
                    data = addOrRemoveData("สิวระดับปานกลาง");
                    widget._listener.call(data);
                    setState(() {
                      acneSecond = newValue;
                    });
                  }),
              BlossomText(
                "สิวระดับปานกลาง",
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
                    data = addOrRemoveData("สิวระดับรุนแรง");
                    widget._listener.call(data);
                    setState(() {
                      acneThird = newValue;
                    });
                  }),
              BlossomText(
                "สิวระดับรุนแรง",
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
                    data = addOrRemoveData("สิว steroid");
                    widget._listener.call(data);
                    setState(() {
                      acneForth = newValue;
                    });
                  }),
              BlossomText(
                "สิว steroid",
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
                    data = addOrRemoveData("อื่นๆ");
                    widget._listener.call(data);
                    setState(() {
                      acneFifth = newValue;
                    });
                  }),
              BlossomText(
                "อื่นๆ",
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
