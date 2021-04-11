import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/page/webview/web_view_page.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        GridView.count(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(20.0),
        crossAxisSpacing: 10.0,
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        childAspectRatio: 1 / 1,
        children: [
          _createServiceItem(context, "Treatment", "https://www.blossomclinicthailand.com/treatment/"),
          _createServiceItem(context, "กระชับรูขุมขน", "https://www.blossomclinicthailand.com/กระชับรูขุมขน/"),
          _createServiceItem(context, "ปรับรูปหน้า", "https://www.blossomclinicthailand.com/ปรับรูปหน้า/"),
          _createServiceItem(context, "รอยดำ รอยแดง หลุมสิว", "https://www.blossomclinicthailand.com/รอยดำรอยแดงหลุมสิว/"),
          _createServiceItem(context, "วิตามินผิว", "https://www.blossomclinicthailand.com/วิตามินผิว/"),
          _createServiceItem(context, "กำจัดขน", "https://www.blossomclinicthailand.com/กำจัดขน/"),
        ])
        ],
      ),
    );
  }

  Widget _createServiceItem(BuildContext context, String title, String link) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
          return WebViewPage(title, link);
        }));
      },
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset("assets/splashscreen.svg",
                  width: 30 * MediaQuery.of(context).size.width / 100,
              height: 30 * MediaQuery.of(context).size.width / 100,),
            ),
            Expanded(child: Align(
              alignment: Alignment.center,
                child: BlossomText(title, size: 14,)))
          ],
        ),
      ),
    );
  }
}
