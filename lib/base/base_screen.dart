import 'package:blossom_clinic/blossom_theme.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  Widget child;
  bool safeAreaBottom;

  BaseScreen({this.child, this.safeAreaBottom});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: BlossomTheme.white,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 100 * MediaQuery.of(context).size.width / 100,
            child: Image.asset("assets/nav_bar.png"),
          ),
        ),
        SafeArea(
          bottom: safeAreaBottom ?? true,
            child: child)
      ],
    );
  }
}
