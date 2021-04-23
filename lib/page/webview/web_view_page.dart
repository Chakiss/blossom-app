import 'dart:io';

import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/doctor/doctor_provider.dart';
import 'package:blossom_clinic/page/history/history_provider.dart';
import 'package:blossom_clinic/page/login/login_provider.dart';
import 'package:blossom_clinic/page/main/main_page.dart';
import 'package:blossom_clinic/page/main/main_provider.dart';
import 'package:blossom_clinic/page/profile/profile_provider.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
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
              javascriptChannels: <JavascriptChannel>{
                _doneJavascriptChannel(context),
              },
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: link,
            ))
          ],
        ),
      ),
    );
  }

  JavascriptChannel _doneJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Blossom',
        onMessageReceived: (JavascriptMessage message) {
          // Navigator.of(context).pushAndRemoveUntil(, (route) => false);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (BuildContext context) => MainProvider(),
                ),
                ChangeNotifierProvider(
                  create: (BuildContext context) => DoctorProvider(Injector.appInstance.get()),
                ),
                ChangeNotifierProvider(
                  create: (BuildContext context) => HistoryProvider(Injector.appInstance.get(), Injector.appInstance.get()),
                ),
                ChangeNotifierProvider(
                  create: (BuildContext context) => LoginProvider(Injector.appInstance.get(), Injector.appInstance.get(), FirebaseAuth.instance),
                ),
                ChangeNotifierProvider(
                  create: (BuildContext context) => ProfileProvider(),
                ),
              ],
              child: MainPage(),
            );
          }), (route) => false);
        });
  }
}
