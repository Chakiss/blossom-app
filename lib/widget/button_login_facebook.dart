import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class ButtonLoginFacebook extends StatelessWidget {
  String text;
  bool isEnable;
  double width;
  double height;
  double radius;
  double textSize;
  FontWeight fontWeight;
  EdgeInsetsGeometry padding;
  Function() onPressed;

  ButtonLoginFacebook(this.text, this.isEnable, this.onPressed,
      {this.width, this.height, this.radius, this.textSize, this.padding, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)), color: Color(0xFF4868AD)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.only(left: 12, right: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                child: Image.asset("assets/logo_facebook_white.png")),
            BlossomText(
              text,
              size: textSize ?? 16,
              color: isEnable ? BlossomTheme.white : BlossomTheme.black,
              fontWeight: fontWeight,
            )
          ],
        ),
        onPressed: isEnable ? onPressed : null,
      ),
    );
  }
}
