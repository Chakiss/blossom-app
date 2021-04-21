import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/widget/doctor_duration_choice.dart';
import 'package:flutter/material.dart';

class ConfirmConsultProvider extends BaseProvider with ChangeNotifier {

  DoctorDurationChoice doctorDurationChoice;
  int currentMinute;
  List<Widget> dateReserveList;
  var selectedIndex = -1;

  Future<void> callServiceGetDoctorMinConsult(BuildContext context) async {
  }

  Future<void> callServiceGetDoctorTimeReserve(BuildContext context) async {
    selectedIndex = -1;

  }
}
