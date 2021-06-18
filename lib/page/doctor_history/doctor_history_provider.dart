import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/usecase/filter_appointment_by_type_use_case.dart';
import 'package:blossom_clinic/usecase/get_appointment_by_doctor_id_use_case.dart';
import 'package:flutter/material.dart';

class DoctorHistoryProvider extends BaseProvider with ChangeNotifier {

  GetAppointmentByDoctorIdUseCase _getAppointmentByDoctorIdUseCase;
  FilterAppointmentByTypeUseCase _filterAppointmentByTypeUseCase;

  DoctorHistoryProvider(this._getAppointmentByDoctorIdUseCase, this._filterAppointmentByTypeUseCase);
  List<AppointmentModel> list;
  List<AppointmentModel> _nowList;
  List<AppointmentModel> _oldList;

  Future<void> getAppointmentByDoctorId(BuildContext context, String doctorId) async {
    list = null;
    notifyListeners();
    final result = await _getAppointmentByDoctorIdUseCase.execute(doctorId);
    result.whenWithResult((data) {
      _filterAppointmentList(context, data);
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }

  void _filterAppointmentList(BuildContext context, List<AppointmentModel> data) {
    final result = _filterAppointmentByTypeUseCase.execute(data);
    result.whenWithResult((map) {
      _nowList = map["nowList"];
      _oldList = map["oldList"];
      list = _nowList;
      notifyListeners();
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }

  void showNowList() {
    if (list != _nowList) {
      list = _nowList;
      notifyListeners();
    }
  }

  void showOldList() {
    if (list != _oldList) {
      list = _oldList;
      notifyListeners();
    }
  }
}