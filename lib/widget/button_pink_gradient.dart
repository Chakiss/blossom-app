import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class ButtonPinkGradient extends StatelessWidget {
  String text;
  bool isEnable;
  double width;
  double height;
  double radius;
  double textSize;
  EdgeInsetsGeometry padding;
  Function() onPressed;

  ButtonPinkGradient(this.text, this.isEnable, this.onPressed,
      {this.width, this.height, this.radius, this.textSize, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? null,
      height: height ?? null,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
          gradient: LinearGradient(
            colors: isEnable ? [Color(0xFFEF567E), Color(0xFFE8A872)] : [BlossomTheme.white, BlossomTheme.white],
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
          color: isEnable ? BlossomTheme.white : BlossomTheme.black,
        ),
        onPressed: isEnable ? onPressed : null,
      ),
    );
  }
}
