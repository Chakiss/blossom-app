import 'dart:async';
import 'dart:io';

import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../blossom_theme.dart';

class DrugPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller = Completer<WebViewController>();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    return Scaffold(
      backgroundColor: BlossomTheme.darkPink,
      body: SafeArea(
        child: Column(
          children: [
            Toolbar(
              title: "ยา",
              backgroundColor: BlossomTheme.darkPink,
              titleSize: 24,
              padding: 12,
            ),
            Expanded(
                child: Container(
              color: BlossomTheme.white,
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: "https://www.blossomclinicthailand.com/สินค้า/",
                onWebViewCreated: (_) async {
                  // _controller.complete(_);
                  await _.clearCache();
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
