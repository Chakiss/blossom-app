import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class HistorySegmentItem extends StatelessWidget {
  String text;
  bool isEnable;
  double width;
  double height;
  double textSize;
  EdgeInsetsGeometry padding;
  double radiusTopLeft, radiusTopRight, radiusBottomLeft, radiusBottomRight;
  Function() onPressed;

  HistorySegmentItem(this.text, this.isEnable, this.onPressed,
      {this.width,
      this.height,
      this.textSize,
      this.padding,
      this.radiusTopLeft,
      this.radiusTopRight,
      this.radiusBottomLeft,
      this.radiusBottomRight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? null,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusTopLeft ?? 0),
              topRight: Radius.circular(radiusTopRight ?? 0),
              bottomLeft: Radius.circular(radiusBottomLeft ?? 0),
              bottomRight: Radius.circular(radiusBottomRight ?? 0)),
          gradient: LinearGradient(
            colors: isEnable ? [Color(0xFFEF567E), Color(0xFFE8A872)] : [Color(0xFFBDBDBD), Color(0xFFBDBDBD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: padding ?? null,
        ),
        child: BlossomText(
          text,
          size: textSize ?? 16,
          color: BlossomTheme.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
