import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/page/doctor_order_detail/appointment_pre_page.dart';
import 'package:flutter/material.dart';

class DoctorAppointmentDetailProvider extends BaseProvider with ChangeNotifier {

  Widget page;

  void initialPage(AppointmentModel appointmentModel) {
    page = AppointmentPrePage(appointmentModel.form.pre);
    notifyListeners();
  }
}