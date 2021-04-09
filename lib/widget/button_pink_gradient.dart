import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class ButtonPinkGradient extends StatelessWidget {
  String text;
  Function() onPressed;

  ButtonPinkGradient(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xFFEF567E), Color(0xFFE8A872)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.transparent, elevation: 0, shadowColor: Colors.transparent),
        child: BlossomText(
          text,
          size: 16,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
