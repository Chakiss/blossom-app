import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class AcneMultiChoice extends StatefulWidget {
  Function(String) _listener;

  AcneMultiChoice(this._listener);

  @override
  AcneMultiChoiceState createState() => AcneMultiChoiceState();
}

class AcneMultiChoiceState extends State<AcneMultiChoice> {
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
              Row(
                children: [
                  Checkbox(
                      value: acneFirst,
                      fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                      onChanged: (bool newValue) {
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
                        setState(() {
                          acneSecond = newValue;
                        });
                      }),
                  BlossomText(
                    "สิวระดับปานกลาง",
                    size: 15,
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  Checkbox(
                      value: acneThird,
                      fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                      onChanged: (bool newValue) {
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
                        setState(() {
                          acneForth = newValue;
                        });
                      }),
                  BlossomText(
                    "สิว steroid",
                    size: 15,
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: acneFifth,
                  fillColor: MaterialStateProperty.all(BlossomTheme.darkPink),
                  onChanged: (bool newValue) {
                    setState(() {
                      acneFifth = newValue;
                    });
                  }),
              BlossomText(
                "อื่นๆ",
                size: 15,
              )
            ],
          )
        ],
      ),
    );
  }
}
