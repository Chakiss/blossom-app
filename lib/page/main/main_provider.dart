import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/doctor/doctor_page.dart';
import 'package:flutter/material.dart';

class MainProvider extends BaseProvider with ChangeNotifier {

  Widget page = DoctorPage();

  void setPage(Widget page) {
    this.page = page;
    notifyListeners();
  }
}