import 'package:flutter/material.dart';

import '../blossom_theme.dart';
import 'blossom_text.dart';

class TextStrokePink extends StatelessWidget {
  String text;
  Function() _listener;
  double size;
  EdgeInsets padding;

  TextStrokePink(this.text, this._listener,
      {Key key, this.size = 13, this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 2)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _listener,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
            border: Border.all(color: BlossomTheme.darkPink), borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Center(
          child: BlossomText(
            text,
            size: size,
            color: BlossomTheme.darkPink,
          ),
        ),
      ),
    );
  }
}
