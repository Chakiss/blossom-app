import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/text_field_stroke_dark_pink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'blossom_text.dart';
import 'custom_list_dialog.dart';

class DayAndCvvSection extends StatefulWidget {
  Function(String) onDataChange;

  DayAndCvvSection(this.onDataChange);

  @override
  _DayAndCvvSectionState createState() => _DayAndCvvSectionState();
}

class _DayAndCvvSectionState extends State<DayAndCvvSection> {
  var monthText = "MM";
  var yearText = "YY";
  var cvvText = "XXX";
  List<String> monthData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];
  List<String> yearData = ["21", "22", "23", "24", "25", "26", "27", "28", "29", "30"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80 * MediaQuery.of(context).size.width / 100,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: BlossomText(
                "วันหมดอายุ",
                size: 15,
              )),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Column(
                      children: [
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                              border: Border.all(color: BlossomTheme.darkPink),
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            children: [
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.all(13),
                                  child: BlossomText(
                                    monthText,
                                    size: 15,
                                    color: BlossomTheme.darkPink,
                                  ),
                                ),
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomListDialog(monthData, (value) {
                                        setState(() {
                                          monthText = value;
                                          widget.onDataChange("$monthText $yearText $cvvText");
                                        });
                                      });
                                    },
                                  );
                                },
                              ),
                              Container(
                                color: BlossomTheme.darkPink,
                                width: 1,
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: BlossomTheme.darkPink,
                                size: 16,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                  border: Border.all(color: BlossomTheme.darkPink),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(13),
                                    child: BlossomText(yearText, size: 15, color: BlossomTheme.darkPink),
                                  ),
                                  Container(
                                    color: BlossomTheme.darkPink,
                                    width: 1,
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: BlossomTheme.darkPink,
                                    size: 16,
                                  )
                                ],
                              )),
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomListDialog(yearData, (value) {
                                  setState(() {
                                    yearText = value;
                                    widget.onDataChange("$monthText $yearText $cvvText");
                                  });
                                });
                              },
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          Container(
            width: 22,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: BlossomText(
                  "รหัส CVV",
                  size: 15,
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Container(
                        width: 60,
                        child: TextFieldStrokeDarkPink(
                          cvvText,
                          width: 60,
                          paddingStart: 4,
                          paddingEnd: 4,
                          textAlign: TextAlign.center,
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          onChange: (value) {
                            cvvText = value;
                            widget.onDataChange("$monthText $yearText $cvvText");
                          },
                        )),
                  ),
                  Container(margin: EdgeInsets.only(left: 9), child: SvgPicture.asset("assets/ic_cvv_card.svg"))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
