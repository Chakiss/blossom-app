import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../blossom_theme.dart';

class CustomerInformationItem extends StatelessWidget {
  bool isFirstItem;

  CustomerInformationItem({this.isFirstItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15 * MediaQuery.of(context).size.width / 100,
      margin: EdgeInsets.only(left: isFirstItem ? 0 : 12),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: DottedBorder(
            color: BlossomTheme.black,
            strokeWidth: 1,
            child: Center(child: Icon(Icons.add))
        ),
      ),
    );
  }
}
