import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/doctor/doctor_page.dart';
import 'package:blossom_clinic/page/drug/drug_page.dart';
import 'package:blossom_clinic/page/history/history_page.dart';
import 'package:blossom_clinic/page/profile/profile_page.dart';
import 'package:blossom_clinic/page/service/service_page.dart';
import 'package:flutter/material.dart';

class MainProvider extends BaseProvider with ChangeNotifier {

  int initIndex;
  Widget page;

  MainProvider({this.initIndex = 0}) {
    switch (initIndex) {
      case 0:
        page = DoctorPage();
        break;
      case 1:
        page = HistoryPage();
        break;
      case 2:
        page = ServicePage();
        break;
      case 3:
        page = DrugPage();
        break;
      case 4:
        page = ProfilePage();
        break;
    }
  }

  void setPage(Widget page) {
    this.page = page;
    notifyListeners();
  }
}