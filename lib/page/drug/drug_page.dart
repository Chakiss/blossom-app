import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../blossom_theme.dart';

class DrugPage extends StatelessWidget {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    flutterWebViewPlugin.close();
    return Scaffold(
      backgroundColor: BlossomTheme.darkPink,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Toolbar(
              title: "ยา",
              backgroundColor: BlossomTheme.darkPink,
              titleSize: 24,
              padding: 12,
            ),
            Expanded(
                child: WebviewScaffold(
                    url: "https://www.blossomclinicthailand.com/%E0%B8%AA%E0%B8%B4%E0%B8%99%E0%B8%84%E0%B9%89%E0%B8%B2",
                    appCacheEnabled: true,
                    withZoom: true,
                    withLocalStorage: true,
                    withJavascript: true,
                    hidden: true,
                    initialChild: Container(color: BlossomTheme.white, child: BlossomProgressIndicator())))
          ],
        ),
      ),
    );
  }
}
