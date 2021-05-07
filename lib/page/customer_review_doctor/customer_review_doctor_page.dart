import 'package:blossom_clinic/base/base_screen_second.dart';
import 'package:blossom_clinic/page/customer_review_doctor/customer_review_doctor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerReviewDoctorPage extends StatelessWidget {
  CustomerReviewDoctorPage({Key key}) : super(key: key);

  CustomerReviewDoctorProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    return BaseScreenSecond(
      title: "รีวิวแพทย์",
      child: Container(),
    );
  }
}
