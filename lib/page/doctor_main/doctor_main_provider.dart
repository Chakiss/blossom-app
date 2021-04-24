import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/page/doctor_home/doctor_home_page.dart';
import 'package:flutter/material.dart';

class DoctorMainProvider extends BaseProvider with ChangeNotifier {

  Widget page = DoctorHomePage();

  void setPage(Widget page) {
    this.page = page;
    notifyListeners();
  }
}