import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/widget/doctor_duration_choice.dart';
import 'package:flutter/material.dart';

class ConfirmConsultProvider extends BaseProvider with ChangeNotifier {

  DoctorDurationChoice doctorDurationChoice;
  int currentMinute;

  Future<void> callServiceGetDoctorMinConsult() async {
    final result = await remoteRepository.getDoctorMinConsult();
    result.whenWithResult((data) {
      if (data?.data != null) {
        doctorDurationChoice = DoctorDurationChoice(list: data?.data, listener: (value) {
          currentMinute = value;
        });
        notifyListeners();
      }
    }, (statusModel) => {

    });
  }
}