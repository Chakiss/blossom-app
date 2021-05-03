import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class AppointmentPostPage extends StatelessWidget {
  Post _post;

  AppointmentPostPage(this._post);

  @override
  Widget build(BuildContext context) {
    return !_post.isCompleted ? Container(
      child: Center(
        child: BlossomText("ยังไม่มีข้อมูลการวินิจฉัย", size: 20,),
      ),
    ) : SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 7 * MediaQuery.of(context).size.width / 100),
            child: Column()));
  }
}
