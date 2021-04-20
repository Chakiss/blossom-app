import 'package:blossom_clinic/blossom_theme.dart';
import 'package:flutter/material.dart';

class TextFieldStrokeBlack extends StatelessWidget {
  String hint;
  double width;
  double height;
  double paddingStart;
  double paddingEnd;
  TextAlign textAlign;
  TextEditingController textController;
  int maxLength;
  bool isPasswordType;
  Function(String) onChange;

  TextFieldStrokeBlack(this.hint,
      {this.width,
        this.height,
        this.paddingStart,
        this.paddingEnd,
        this.textAlign,
        this.maxLength,
        this.onChange,
        this.isPasswordType,
        this.textController});

  String getText() => textController.text;

  static const String FONT_PROMPT = "Prompt";
  static const String FONT_ASAP = "Asap";

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
          width: width ?? 80 * MediaQuery
              .of(context)
              .size
              .width / 100,
          height: height ?? 48,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: BlossomTheme.black), borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Container(
              padding: EdgeInsets.only(left: paddingStart ?? 18, right: paddingEnd ?? 18),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Center(
                        child: TextField(
                            obscureText: isPasswordType ?? false,
                            onChanged: onChange ?? (value) {},
                            controller: textController ?? TextEditingController(),
                            buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) =>
                            null,
                            maxLength: maxLength ?? 50,
                            style: TextStyle(color: BlossomTheme.black, fontFamily: FONT_PROMPT, fontSize: 15),
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
