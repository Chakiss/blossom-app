import 'dart:io';

import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  String title;
  String link;

  WebViewPage(this.title, this.link);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> with WidgetsBindingObserver {
  bool isFirstTime = true;
  WebViewController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    return Scaffold(
      backgroundColor: BlossomTheme.pink,
      body: SafeArea(
        child: Column(
          children: [
            ToolbarBack(
              title: widget.title,
              backgroundColor: BlossomTheme.pink,
              titleSize: 16,
              padding: 8,
            ),
            Expanded(
                child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.link,
              onWebViewCreated: (webViewController) {
                controller = webViewController;
              },
              navigationDelegate: (request) {
                if (request.url.startsWith('scbeasy') || request.url.startsWith('market://')) {
                  _launchURL(request.url);
                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
        // widget is resumed
        print("Prew: onResume");
        if (!isFirstTime) {
          controller.loadUrl(widget.link);
        }
        break;
      case AppLifecycleState.inactive:
        // widget is inactive
        break;
      case AppLifecycleState.paused:
        // widget is paused
        print("Prew: onPause");
        isFirstTime = false;
        break;
      case AppLifecycleState.detached:
        // widget is detached
        break;
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
