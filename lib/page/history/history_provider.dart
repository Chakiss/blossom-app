import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/usecase/get_appointment_by_user_id_use_case.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:flutter/material.dart';

class HistoryProvider extends BaseProvider with ChangeNotifier {

  GetAppointmentByUserIdUseCase _getAppointmentByUserIdUseCase;
  UserData _userData;
  List<AppointmentModel> appointmentList;

  HistoryProvider(this._getAppointmentByUserIdUseCase, this._userData);

  Future<void> getAppointmentList(BuildContext context) async {
    final result = await _getAppointmentByUserIdUseCase.execute(_userData.userProfileModel.userUID);
    result.whenWithResult((data) {
      appointmentList = data;
      notifyListeners();
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }
}