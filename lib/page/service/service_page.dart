import 'package:blossom_clinic/base/base_screen_second.dart';
import 'package:blossom_clinic/page/service/service_provider.dart';
import 'package:blossom_clinic/widget/blossom_image.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicePage extends StatelessWidget {
  ServiceProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.callServiceGetReview();
    return BaseScreenSecond(
      title: "รีวิว",
      child: Consumer<ServiceProvider>(
        builder: (BuildContext context, ServiceProvider value, Widget child) {
          if (value.list == null) {
            return Container(
                child: Center(
              child: BlossomProgressIndicator(),
            ));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: value.list.map((e) => _createReviewItem(context, e)).toList(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _createReviewItem(BuildContext context, Map<String, String> map) {
    return Column(
      children: [
        BlossomText(
          map["title"],
          size: 22,
          fontWeight: FontWeight.bold,
        ),
        BlossomImage(
          fileStorePath: map["image"],
          width: 60 * MediaQuery.of(context).size.width / 100,
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }
}
