import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/doctor_review_model.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorReviewItem extends StatelessWidget {
  DoctorReviewModel _doctorReviewModel;

  DoctorReviewItem(this._doctorReviewModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10 * MediaQuery
          .of(context)
          .size
          .width / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BlossomText(
                "วันที่",
                size: 16,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                width: 4,
              ),
              BlossomText(
                DateFormat("d MMMM yyyy", "TH").format(_doctorReviewModel.createdAt.toDate()),
                size: 16,
              ),
              SizedBox(width: 4,),
              Row(children: _getRating(),)
            ],
          ),
          SizedBox(height: 10,),
          BlossomText(_doctorReviewModel.comment ?? "", size: 16,),
          SizedBox(height: 20,),
          Container(height: 1, color: BlossomTheme.darkPink,),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  List<Widget> _getRating() {
    List<Widget> list = [];
    for (var i = 0; i < _doctorReviewModel.score; i++) {
      list.add(Icon(
        Icons.star_rate_rounded,
        size: 24,
        color: Colors.yellow,
      ));
    }
    return list;
  }
}
