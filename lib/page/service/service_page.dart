import 'dart:async';

import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../blossom_theme.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {

  bool isLoad = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlossomTheme.darkPink,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Toolbar(
              title: "รีวิว",
              backgroundColor: BlossomTheme.darkPink,
              titleSize: 24,
              padding: 12,
            ),
            Expanded(
                child: Stack(
                  children: [
                    Container(
                      color: BlossomTheme.white,
                      child: WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl: "https://www.blossomclinicthailand.com/review/",
                        onPageFinished: (String url) {
                          setState(() {
                            isLoad = false;
                          });
                        },
                      ),
                    ),
                    if (isLoad) BlossomProgressIndicator()
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
