import 'package:blossom_clinic/blossom_theme.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  Widget child;

  BaseScreen({this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              color: BlossomTheme.white,
            )),
        Container(
          width: 100 * MediaQuery.of(context).size.width / 100,
          child: Image.asset("assets/nav_bar.png"),
        ),
        SafeArea(
            child: Container(
          child: child,
        ))
      ],
    );
  }
}
