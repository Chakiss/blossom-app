import 'dart:convert';

import 'package:blossom_clinic/page/qr_scan/qr_scan_provider.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class QrScanPage extends StatelessWidget {
  String base64String;

  QrScanPage(this.base64String);
  QrScanProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.observeOrderWhenPayment(context);
    return Scaffold(
      backgroundColor: BlossomTheme.pink,
      body: SafeArea(
        child: Column(
          children: [
            ToolbarBack(
              title: "PromptPay",
              backgroundColor: BlossomTheme.pink,
              titleSize: 16,
              padding: 8,
            ),
            Expanded(
                child: Container(
              color: BlossomTheme.white,
              padding: EdgeInsets.symmetric(horizontal: 10 * MediaQuery.of(context).size.width / 100),
              child: Image.memory(base64.decode(base64String.split(',').last)),
            ))
          ],
        ),
      ),
    );
  }
}
