import 'package:blossom_clinic/page/dispense/dispense_provider.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/dispense_item.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class DispensePage extends StatelessWidget {
  DispenseProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.getProductList(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: BlossomTheme.white,
        ),
        Column(
          children: [
            Container(
              width: 100 * MediaQuery.of(context).size.width / 100,
              child: Image.asset("assets/nav_bar.png"),
            ),
            Expanded(
              child: Consumer<DispenseProvider>(
                builder: (BuildContext context, DispenseProvider value, Widget child) {
                  return value.list == null
                      ? BlossomProgressIndicator()
                      : ListView.builder(
                          itemCount: value.list?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return DispenseItem(value.list[index]);
                          },
                        );
                },
              ),
            ),
            ButtonPinkGradient(
              "ยืนยัน",
              true,
              () {},
              width: MediaQuery.of(context).size.width,
              height: 60,
            )
          ],
        ),
        SafeArea(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Toolbar(
              title: "สั่งยา",
            ),
          ],
        ))
      ],
    );
  }
}
