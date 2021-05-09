import 'package:blossom_clinic/base/base_screen_second.dart';
import 'package:blossom_clinic/page/doctor_review/doctor_review_provider.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/doctor_review_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorReviewPage extends StatelessWidget {
  DoctorReviewProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.callServiceGetDoctorReview();
    return BaseScreenSecond(
      true,
      title: "รีวิว",
      child: Consumer<DoctorReviewProvider>(
        builder: (BuildContext context, DoctorReviewProvider value, Widget child) {
          if (value.list == null) {
            return Container(
              child: Center(
                child: BlossomProgressIndicator(),
              ),
            );
          } else {
            if (value.list.isEmpty) {
              return Container(
                  child: Center(
                child: BlossomText("ไม่พบข้อมูล", size: 22,),
              ));
            } else {
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount:  value.list?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return DoctorReviewItem(value.list[index]);
                },
              );
            }
          }
        },
      ),
    );
  }
}
