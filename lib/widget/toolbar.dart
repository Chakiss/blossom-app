import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class Toolbar extends StatelessWidget {
  String title;
  Color titleColor;
  Color backgroundColor;
  double titleSize;
  double padding;
  Toolbar({this.title, this.titleColor, this.backgroundColor, this.titleSize, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: backgroundColor ?? Colors.transparent,
      color: backgroundColor ?? BlossomTheme.darkPink,
      padding: EdgeInsets.symmetric(horizontal: padding ?? 16),
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: BlossomText(
                    title ?? "",
                    color: titleColor ?? BlossomTheme.white,
                    size: titleSize ?? 28,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
