import 'dart:io';

import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {

  String _imagePath;

  ImageDialog(this._imagePath, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        child: Image.file(File(_imagePath)),
      ),
    );
  }
}
