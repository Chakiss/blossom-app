import 'package:blossom_clinic/page/dispense/dispense_provider.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/dispense_item.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class DispensePage extends StatelessWidget {
  DispenseProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.getProductList(context);
    return Scaffold(
      backgroundColor: BlossomTheme.darkPink,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ToolbarBack(
            title: "สั่งยา",
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              color: BlossomTheme.white,
              child: Consumer<DispenseProvider>(
                builder: (BuildContext context, DispenseProvider value, Widget child) {
                  return value.list == null
                      ? BlossomProgressIndicator()
                      : ListView.builder(
                          itemCount: value.list?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return DispenseItem(value.list[index], (product, amount) {
                              _provider.addProductToOrder(product, amount);
                            });
                          },
                        );
                },
              ),
            ),
          ),
          ButtonPinkGradient(
            "ยืนยัน",
            true,
            () {
              _provider.callServiceCreateOrder(context);
            },
            width: MediaQuery.of(context).size.width,
            height: 60,
          ),
        ],
      )),
    );
  }
}
