import 'package:flutter/material.dart';

import '../blossom_theme.dart';

class BlossomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(BlossomTheme.pink),));
  }
}
