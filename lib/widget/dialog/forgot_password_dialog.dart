import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/text_field_stroke_black.dart';
import 'package:blossom_clinic/widget/text_field_stroke_dark_pink.dart';
import 'package:flutter/material.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final String title, description, positiveButton, negativeButton;
  Function(String) positiveListener;
  Function() negativeListener;

  final _emailTextController = TextEditingController();

  ForgotPasswordDialog(
      {@required this.title,
      @required this.description,
      @required this.positiveButton,
      @required this.positiveListener,
      @required this.negativeButton,
      @required this.negativeListener});

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
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            TextFieldStrokeDarkPink(
              "email@email.com",
              keyboardType: TextInputType.emailAddress,
              textController: _emailTextController,
            ),
            SizedBox(height: 24.0),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Spacer(),
                  negativeButton.isEmpty
                      ? SizedBox()
                      : TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith((states) => BlossomTheme.lightPink),
                          ),
                          onPressed: negativeListener,
                          child: BlossomText(
                            negativeButton,
                            size: 15,
                            color: BlossomTheme.black,
                          )),
                  TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith((states) => BlossomTheme.lightPink),
                      ),
                      onPressed: () {
                        positiveListener.call(_emailTextController.text ?? "");
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
