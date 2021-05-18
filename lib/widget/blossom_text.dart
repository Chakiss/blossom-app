import 'package:blossom_clinic/blossom_theme.dart';
import 'package:flutter/material.dart';

class BlossomText extends StatelessWidget {
  String text;
  Color color;
  double size;
  FontWeight fontWeight;
  String font;
  int maxLines;
  TextAlign textAlign;

  static const String FONT_PROMPT = "Prompt";
  static const String FONT_ASAP = "Asap";

  BlossomText(this.text, {this.color, this.size, this.fontWeight, this.font, this.maxLines, this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      maxLines: maxLines ?? null,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: ((size ?? 10) * (MediaQuery.of(context).size.width)) / 448,
          // fontSize: size ?? 10,
          color: color ?? BlossomTheme.black,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontFamily: font ?? FONT_PROMPT),
      textAlign: textAlign,
    );
  }
}
