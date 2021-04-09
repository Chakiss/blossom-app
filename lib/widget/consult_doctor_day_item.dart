import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class ConsultDoctorDayItem extends StatelessWidget {
  String text;
  Function() onPressed;

  ConsultDoctorDayItem(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
          gradient: LinearGradient(
        colors: [Color(0xFFEF567E), Color(0xFFE8A872)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(0), primary: Colors.transparent, elevation: 0, shadowColor: Colors.transparent),
        child: BlossomText(
          text,
          size: 12,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
