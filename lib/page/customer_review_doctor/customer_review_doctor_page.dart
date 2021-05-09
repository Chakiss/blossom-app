import 'package:blossom_clinic/base/base_screen_second.dart';
import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/doctor_info_model.dart';
import 'package:blossom_clinic/page/customer_review_doctor/customer_review_doctor_provider.dart';
import 'package:blossom_clinic/widget/blossom_circle_avatar.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/rating_view.dart';
import 'package:blossom_clinic/widget/text_field_stroke_black.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerReviewDoctorPage extends StatelessWidget {
  DoctorInfoModel _doctorInfoModel;

  CustomerReviewDoctorPage(this._doctorInfoModel, {Key key}) : super(key: key);

  final _commentTextEditController = TextEditingController();
  CustomerReviewDoctorProvider _provider;
  String rating;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    return BaseScreenSecond(
      true,
      title: "รีวิวแพทย์",
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8 * MediaQuery.of(context).size.width / 100),
          child: Column(
            children: [
              BlossomCircleAvatar(
                72,
                fileStorePath: _doctorInfoModel?.displayPhoto,
              ),
              SizedBox(
                height: 16,
              ),
              BlossomText(
                _doctorInfoModel.displayName ?? "",
                color: BlossomTheme.darkPink,
                size: 22,
                fontWeight: FontWeight.bold,
              ),
              BlossomText(
                "${_doctorInfoModel.firstName} ${_doctorInfoModel.lastName}",
                size: 18,
              ),
              SizedBox(
                height: 16,
              ),
              RatingView((rating) {
                this.rating = "$rating";
              }),
              SizedBox(
                height: 36,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: BlossomText(
                  "ความคิดเห็น",
                  size: 16,
                  color: BlossomTheme.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFieldStrokeBlack(
                "ความคิดเห็น",
                height: 100,
                textAlignVertical: TextAlignVertical.top,
                textController: _commentTextEditController,
                maxLines: 3,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 30,
              ),
              ButtonPinkGradient("บันทึก", true, () {
                _provider.callServiceReviewAppointment(context, rating, _commentTextEditController.text);
              },
              width: 100, radius: 6,),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
