import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/usecase/get_appointment_by_doctor_id_use_case.dart';
import 'package:flutter/material.dart';

class DoctorHistoryProvider extends BaseProvider with ChangeNotifier {

  GetAppointmentByDoctorIdUseCase _getAppointmentByDoctorIdUseCase;

  DoctorHistoryProvider(this._getAppointmentByDoctorIdUseCase);
  List<dynamic> list;

  Future<void> getAppointmentByDoctorId(BuildContext context, String doctorId) async {
    final result = await _getAppointmentByDoctorIdUseCase.execute(doctorId);
    result.whenWithResult((data) {
      list = data;
      notifyListeners();
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }
}