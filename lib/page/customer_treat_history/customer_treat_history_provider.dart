import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/usecase/get_appointment_by_user_id_use_case.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:flutter/material.dart';

class CustomerTreatHistoryProvider extends BaseProvider with ChangeNotifier {

  UserData _userData;
  GetAppointmentByUserIdUseCase _getAppointmentByUserIdUseCase;

  CustomerTreatHistoryProvider(this._userData, this._getAppointmentByUserIdUseCase);

  List<AppointmentModel> list;

  Future<void> callServiceGetAppointmentList() async {
    final result = await _getAppointmentByUserIdUseCase.execute(_userData.userProfileModel.userUID);
    result.whenWithResult((data) {
      list = data["rawList"] ?? [];
      notifyListeners();
    }, (map) {

    });
  }
}