import 'dart:io';

import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  String title;
  String link;

  WebViewPage(this.title, this.link);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    return Scaffold(
      backgroundColor: BlossomTheme.pink,
      body: SafeArea(
        child: Column(
          children: [
            ToolbarBack(
              title: title,
              backgroundColor: BlossomTheme.pink,
              titleSize: 16,
              padding: 8,
            ),
            Expanded(
                child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: link,
              onPageStarted: (String url) {
                if (url.startsWith("https://webhook.site")) {
                  Navigator.pop(context, true);
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
