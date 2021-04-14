import 'package:blossom_clinic/blossom_theme.dart';
import 'package:flutter/material.dart';

class TextFieldStrokeDarkPink extends StatelessWidget {

  String hint;
  double width;
  double height;
  double paddingStart;
  double paddingEnd;
  TextAlign textAlign;
  int maxLength;
  Function(String) onChange;

  TextFieldStrokeDarkPink(this.hint, {this.width, this.height, this.paddingStart, this.paddingEnd, this.textAlign, this.maxLength, this.onChange});

  var textController = TextEditingController();

  String getText() => textController.text;

  static const String FONT_PROMPT = "Prompt";
  static const String FONT_ASAP = "Asap";

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
          width: width ?? 80 * MediaQuery.of(context).size.width / 100,
          height: height ?? 48,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: BlossomTheme.darkPink), borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Container(
              padding: EdgeInsets.only(left: paddingStart ?? 18, right: paddingEnd ?? 18),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Center(
                        child: TextField(
                          onChanged: onChange ?? (value) {

                          },
                            controller: textController,
                            buildCounter: (BuildContext context, { int currentLength, int maxLength, bool isFocused }) => null,
                            maxLength: maxLength ?? 50,
                            style: TextStyle(color: BlossomTheme.darkPink, fontFamily: FONT_PROMPT, fontSize: 15),
                            textAlign: textAlign ?? TextAlign.left,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: hint,
                                hintStyle: TextStyle(color: BlossomTheme.gray))),
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
