import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/usecase/get_appointment_list_by_user_id_use_case.dart';
import 'package:blossom_clinic/usecase/get_user_profile_by_id_use_case.dart';
import 'package:flutter/material.dart';

class AppointmentCustomerHistoryDataProvider extends BaseProvider with ChangeNotifier {

  AppointmentModel _appointmentModel;
  GetAppointmentListByUserIdUseCase _getAppointmentListByUserIdUseCase;

  AppointmentCustomerHistoryDataProvider(this._appointmentModel, this._getAppointmentListByUserIdUseCase);

  bool isFirstTime = true;
  List<AppointmentModel> appointmentList;

  Future<void> getAppointmentListByUserId() async {
    final result = await _getAppointmentListByUserIdUseCase.execute(_appointmentModel.userReference.id);
    result.whenWithResult((data) {
      isFirstTime = false;
      appointmentList = data;
      notifyListeners();
    }, (map) {

    });
  }
}