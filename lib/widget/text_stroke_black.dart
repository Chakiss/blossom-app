import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class TextStrokeBlack extends StatelessWidget {
  String text;
  double width;
  double height;
  double paddingStart;
  double paddingEnd;
  double size;
  TextAlign textAlign;

  TextStrokeBlack(this.text, {this.width, this.height, this.paddingStart, this.paddingEnd, this.size, this.textAlign});

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
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: BlossomText(
                    text,
                    size: size ?? 15,
                    color: BlossomTheme.black,
                    textAlign: textAlign,
                  ),
                ),
                flex: 1,
              )
            ],
          )),
    );
  }
}
