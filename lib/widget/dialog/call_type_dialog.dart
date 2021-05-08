import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

import '../../blossom_theme.dart';

class CallTypeDialog extends StatelessWidget {

  Function(int) _listener;

  CallTypeDialog(this._listener, {Key key}) : super(key: key);

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
              "เลือกรูปแบบการติดต่อ",
              size: 18,
              color: BlossomTheme.colorPrimary,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    _listener?.call(0);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.chat,
                        color: BlossomTheme.darkPink,
                        size: 44,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      BlossomText(
                        "Chat",
                        size: 16,
                      ),
                      SizedBox(
                        height: 12,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _listener?.call(1);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.keyboard_voice,
                        color: BlossomTheme.darkPink,
                        size: 44,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      BlossomText(
                        "Voice",
                        size: 16,
                      ),
                      SizedBox(
                        height: 12,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _listener?.call(2);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.video_call,
                        color: BlossomTheme.darkPink,
                        size: 44,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      BlossomText(
                        "Video",
                        size: 16,
                      ),
                      SizedBox(
                        height: 12,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
