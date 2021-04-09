import 'package:flutter/material.dart';

class BlossomText extends StatelessWidget {
  String text;
  Color color;
  double size;
  FontWeight fontWeight;
  String font;


  static const String FONT_PROMPT = "Prompt";
  static const String FONT_ASAP = "Asap";

  BlossomText(this.text, {this.color, this.size, this.fontWeight, this.font});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: size ?? 10,
          color: color ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontFamily: font ?? FONT_PROMPT),
    );
  }
}
