import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class ButtonPinkGradientSmall extends StatelessWidget {

  String text;
  bool isEnable;
  Function() onPressed;

  ButtonPinkGradientSmall(this.text, this.isEnable, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          gradient: LinearGradient(
            colors: isEnable ? [Color(0xFFEF567E), Color(0xFFE8A872)] : [BlossomTheme.white, BlossomTheme.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(left: 40, right: 40, top: 0, bottom: 0),
            primary: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.transparent),
        child: BlossomText(
          text,
          size: 16,
          color: isEnable ? BlossomTheme.white : BlossomTheme.black,
        ),
        onPressed: isEnable ? onPressed : null,
      ),
    );
  }
}
