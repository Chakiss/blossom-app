import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';

import '../blossom_theme.dart';

class ChatItem extends StatelessWidget {
  CubeMessage _cubeMessage;
  bool isSender;

  ChatItem(this._cubeMessage, this.isSender, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSender) {
      return Row(
        children: [
          Spacer(),
          Container(
            // width: 60 * MediaQuery.of(context).size.width / 100,
            constraints: BoxConstraints(maxWidth: 60 * MediaQuery.of(context).size.width / 100),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: BlossomTheme.darkPink),
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: BlossomTheme.darkPink),
            child: BlossomText(
              _cubeMessage.body ?? "",
              size: 14,
              color: BlossomTheme.white,
            ),
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
