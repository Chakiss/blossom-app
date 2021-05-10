import 'package:blossom_clinic/blossom_theme.dart';
import 'package:flutter/material.dart';

class TextFieldStrokeBlack extends StatelessWidget {
  String hint;
  double width;
  double height;
  double paddingStart;
  double paddingEnd;
  TextAlign textAlign;
  TextAlignVertical textAlignVertical;
  TextEditingController textController;
  int maxLength;
  int maxLines;
  bool isPasswordType;
  Function(String) onChange;
  TextInputType keyboardType;
  bool enabled = true;
  Color strokeColor;

  TextFieldStrokeBlack(this.hint,
      {this.width,
      this.height = 48,
      this.paddingStart,
      this.paddingEnd,
      this.textAlign,
      this.textAlignVertical,
      this.maxLength,
      this.onChange,
      this.isPasswordType,
      this.textController,
      this.keyboardType,
      this.maxLines,
      this.enabled = true,
      this.strokeColor = BlossomTheme.black});

  String getText() => textController.text;

  static const String FONT_PROMPT = "Prompt";
  static const String FONT_ASAP = "Asap";

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
          width: width ?? null,
          height: height,
          padding: EdgeInsets.only(left: paddingStart ?? 18, right: paddingEnd ?? 18),
          decoration: BoxDecoration(
              color: enabled ? BlossomTheme.white : BlossomTheme.lightGrayAlpha,
              border: Border.all(
                color: enabled ? strokeColor : BlossomTheme.gray,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: TextField(
              cursorColor: BlossomTheme.darkPink,
              keyboardType: keyboardType,
              enabled: enabled ?? true,
              obscureText: isPasswordType ?? false,
              onChanged: onChange ?? (value) {},
              controller: textController ?? TextEditingController(),
              buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) => null,
              maxLength: maxLength,
              style: TextStyle(color: BlossomTheme.black, fontFamily: FONT_PROMPT, fontSize: 15),
              textAlign: textAlign ?? TextAlign.left,
              maxLines: maxLines ?? 1,
              textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: hint,
                  hintStyle: TextStyle(color: BlossomTheme.gray)))),
    );
  }
}
