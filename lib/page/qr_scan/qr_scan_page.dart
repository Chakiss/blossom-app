import 'dart:convert';

import 'package:blossom_clinic/page/qr_scan/qr_scan_provider.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class QrScanPage extends StatefulWidget {
  String base64String;

  QrScanPage(this.base64String);

  @override
  _QrScanPageState createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlossomText(
                    "สแกน QR Code เพื่อชำระเงิน",
                    size: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10 * MediaQuery.of(context).size.width / 100),
                    child: Image.memory(base64.decode(widget.base64String.split(',').last)),
                  ),
                  BlossomText(
                    "กรุณาชำระเงินภายในระยะเวลา",
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  CountdownTimer(
                    endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 600,
                    widgetBuilder: (_, CurrentRemainingTime time) {
                      if (time == null) {
                        return Container();
                      }
                      return BlossomText(
                          "${time.min} : ${time.sec} นาที", size: 20,);
                    },
                    onEnd: () {
                      Navigator.pushAndRemoveUntil(context, RouteManager.routeMain(), (route) => false);
                    },
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
