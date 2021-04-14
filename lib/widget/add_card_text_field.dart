import 'package:blossom_clinic/blossom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddCardTextField extends StatelessWidget {

  TextEditingController cardTextController = TextEditingController();

  String getText() => cardTextController.text.replaceAll(RegExp(r' '), "");

  void cardFormat(String text) {
    String textRemoveSpace = text.replaceAll(RegExp(r' '), "");
    if (textRemoveSpace.length % 4 == 0) {
      cardTextController.text =  textRemoveSpace.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");
      cardTextController.selection = TextSelection.fromPosition(TextPosition(offset: cardTextController.text.length));
    }
  }

  static const String FONT_PROMPT = "Prompt";
  static const String FONT_ASAP = "Asap";

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
          width: 80 * MediaQuery.of(context).size.width / 100,
          height: 48,
          margin: EdgeInsets.only(top: 4),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: BlossomTheme.darkPink), borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Container(
              padding: EdgeInsets.only(left: 18, right: 18),
              child: Row(
                children: [
                  SvgPicture.asset("assets/ic_visa.svg"),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: TextField(
                            maxLength: 19,
                            buildCounter: (BuildContext context, { int currentLength, int maxLength, bool isFocused }) => null,
                            controller: cardTextController,
                            onChanged: (text) {
                              cardFormat(text);
                            },
                            style: TextStyle(color: BlossomTheme.darkPink, fontFamily: FONT_PROMPT, fontSize: 15),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "XXXX XXXX XXXX XXXX",
                                hintStyle: TextStyle(
                                    color: BlossomTheme.gray))),
                      ),
                    ),
                    flex: 1,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
