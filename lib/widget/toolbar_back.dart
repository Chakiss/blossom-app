import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class ToolbarBack extends StatelessWidget {
  String title;

  ToolbarBack({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.navigate_before,
                color: BlossomTheme.white,
                size: 40,
              )),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: BlossomText(
                    title ?? "",
                    color: BlossomTheme.white,
                    size: 28,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
