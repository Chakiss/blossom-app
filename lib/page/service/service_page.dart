import 'dart:async';

import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../blossom_theme.dart';

class ServicePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlossomTheme.darkPink,
      body: SafeArea(
        child: Column(
          children: [
            Toolbar(
              title: "รีวิว",
              backgroundColor: BlossomTheme.darkPink,
              titleSize: 24,
              padding: 12,
            ),
            Expanded(
                child: Container(
                  color: BlossomTheme.white,
                  child: WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: "https://www.blossomclinicthailand.com/review/",
                    onWebViewCreated: (_controller) async {
                      await _controller.clearCache();
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }

  // Widget _createServiceItem(BuildContext context, String title, String link) {
  //   return GestureDetector(
  //     behavior: HitTestBehavior.opaque,
  //     onTap: () {
  //       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
  //         return WebViewPage(title, link);
  //       }));
  //     },
  //     child: Card(
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: SvgPicture.asset("assets/splashscreen.svg",
  //                 width: 30 * MediaQuery.of(context).size.width / 100,
  //             height: 30 * MediaQuery.of(context).size.width / 100,),
  //           ),
  //           Expanded(child: Align(
  //             alignment: Alignment.center,
  //               child: BlossomText(title, size: 14,)))
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
