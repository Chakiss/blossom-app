import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../blossom_theme.dart';

class CustomerInformationItem extends StatelessWidget {
  File imageFile;
  bool isFirstItem;
  Function() listener;

  CustomerInformationItem(this.imageFile, {this.isFirstItem, this.listener});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15 * MediaQuery.of(context).size.width / 100,
      margin: EdgeInsets.only(left: isFirstItem ? 0 : 12),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: listener ?? () {},
          child: DottedBorder(
              padding: EdgeInsets.zero,
              color: BlossomTheme.black,
              strokeWidth: 1,
              child: Center(child: imageFile == null ? Icon(Icons.add) : Image.file(imageFile))),
        ),
      ),
    );
  }
}
