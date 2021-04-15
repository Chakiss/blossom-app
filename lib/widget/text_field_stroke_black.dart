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
  TextEditingController textEditingController;
  int maxLength;
  Function(String) onChange;

  TextFieldStrokeBlack(this.hint,
      {this.width,
      this.height,
      this.paddingStart,
      this.paddingEnd,
      this.textAlign,
      this.maxLength,
      this.onChange,
      this.textAlignVertical,
      this.textEditingController});

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
          decoration: BoxDecoration(
              border: Border.all(color: BlossomTheme.black), borderRadius: BorderRadius.all(Radius.circular(5))),
          padding: EdgeInsets.only(left: paddingStart ?? 18, right: paddingEnd ?? 18),
          child: TextField(
              onChanged: onChange ?? (value) {},
              controller: textEditingController ?? textController,
              buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) =>
                  null,
              maxLength: maxLength ?? 50,
              cursorColor: BlossomTheme.darkPink,
              style: TextStyle(color: BlossomTheme.darkPink, fontFamily: FONT_PROMPT, fontSize: 15, height: 2),
              textAlign: textAlign ?? TextAlign.left,
              textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: hint,
                  hintStyle: TextStyle(color: BlossomTheme.gray)))),
    );
  }
}
