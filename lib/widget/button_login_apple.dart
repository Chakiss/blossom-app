import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class ButtonLoginApple extends StatelessWidget {
  String text;
  bool isEnable;
  double width;
  double height;
  double radius;
  double textSize;
  FontWeight fontWeight;
  EdgeInsetsGeometry padding;
  Function() onPressed;

  ButtonLoginApple(this.text, this.isEnable, this.onPressed,
      {this.width, this.height, this.radius, this.textSize, this.padding, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)), color: Colors.black),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.only(left: 12, right: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Image.asset(
                  "assets/ic_apple_logo_black.png",
                  color: Colors.white,
                )),
            SizedBox(
              width: 12,
            ),
            BlossomText(
              text,
              size: textSize ?? 16,
              color: isEnable ? BlossomTheme.white : BlossomTheme.black,
              fontWeight: fontWeight,
            ),
          ],
        ),
        onPressed: isEnable ? onPressed : null,
      ),
    );
  }
}
