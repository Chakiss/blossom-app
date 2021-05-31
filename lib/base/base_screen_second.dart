import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';

class BaseScreenSecond extends StatelessWidget {
  String title;
  Widget child;
  bool isCanBack;
  bool safeAreaBottom;

  BaseScreenSecond(this.isCanBack, {this.title, this.child, this.safeAreaBottom = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlossomTheme.darkPink,
      body: SafeArea(
        bottom: safeAreaBottom ?? false,
        child: Column(
          children: [
            isCanBack
                ? ToolbarBack(title: title)
                : Toolbar(
              title: title,
            ),
            Expanded(child: Container(
                color: BlossomTheme.white, child: child))
          ],
        ),
      ),
    );
  }
}
