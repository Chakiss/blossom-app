import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

import '../../blossom_theme.dart';

class ImagePickerDialog extends StatelessWidget {

  Function(int) _listener;

  ImagePickerDialog(this._listener, {Key key}) : super(key: key);

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
              "เลือกรูปภาพ",
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
                        Icons.image,
                        color: BlossomTheme.darkPink,
                        size: 44,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      BlossomText(
                        "แกลรอรี่",
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
                        Icons.camera_alt,
                        color: BlossomTheme.darkPink,
                        size: 44,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      BlossomText(
                        "กล้อง",
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
