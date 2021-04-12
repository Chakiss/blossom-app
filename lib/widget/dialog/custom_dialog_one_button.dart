import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class CustomDialogOneButton extends StatelessWidget {
  final String title, description, positiveButton;
  Function() positiveListener;

  CustomDialogOneButton(
      {@required this.title, @required this.description, @required this.positiveButton, @required this.positiveListener});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 60 * MediaQuery.of(context).size.width / 100,
        padding: EdgeInsets.only(left: 16, right: 16, top: 12),
        decoration: new BoxDecoration(
          color: BlossomTheme.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            BlossomText(
              title,
              size: 18,
              color: BlossomTheme.colorPrimary,
            ),
            SizedBox(height: 16.0),
            BlossomText(
              description,
              size: 16,
              color: BlossomTheme.black,
            ),
            SizedBox(height: 24.0),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith((states) => BlossomTheme.lightPink),
                      ),
                      onPressed: positiveListener ?? () {
                      },
                      child: BlossomText(
                        positiveButton,
                        size: 15,
                        color: BlossomTheme.colorPrimary,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
