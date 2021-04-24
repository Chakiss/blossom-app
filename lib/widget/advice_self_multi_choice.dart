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
  var adviceFirst = false;
  var adviceSecond = false;
  var adviceThird = false;
  var adviceForth = false;
  var adviceFifth = false;

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
                  Checkbox(
                      value: adviceFirst,
                      fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                      onChanged: (bool newValue) {
                        setState(() {
                          adviceFirst = newValue;
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
                      value: adviceSecond,
                      fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                      onChanged: (bool newValue) {
                        setState(() {
                          adviceSecond = newValue;
                        });
                      }),
                  BlossomText(
                    "งดนอนดึก",
                    size: 15,
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
