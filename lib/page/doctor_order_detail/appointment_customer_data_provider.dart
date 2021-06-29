import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/usecase/get_user_profile_by_id_use_case.dart';
import 'package:flutter/material.dart';

class AppointmentCustomerDataProvider extends BaseProvider with ChangeNotifier {

    AppointmentModel _appointmentModel;
    GetUserProfileByIdUseCase _getUserProfileByIdUseCase;

    AppointmentCustomerDataProvider(this._appointmentModel, this._getUserProfileByIdUseCase);

    UserProfileModel userProfileModel;
    bool isFirstTime = true;

    Future<void> getUserProfileById() async {
      final result = await _getUserProfileByIdUseCase.execute(_appointmentModel.userReference.id);
      result.whenWithResult((data) {
          isFirstTime = false;
          userProfileModel = data;
          notifyListeners();
      }, (map) {

      });
    }
}