import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/available_slot_model.dart';
import 'package:blossom_clinic/model/base/base_request_model.dart';
import 'package:blossom_clinic/model/doctor_info_model.dart';
import 'package:blossom_clinic/model/request/create_appointment_order_model.dart';
import 'package:blossom_clinic/model/slot_model.dart';
import 'package:blossom_clinic/model/time_slot_model.dart';
import 'package:blossom_clinic/usecase/create_appointment_order_use_case.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:flutter/material.dart';

class ConfirmConsultProvider extends BaseProvider with ChangeNotifier {

  CreateAppointmentOrderUseCase _createAppointmentOrderUseCase;
  UserData _userData;

  ConfirmConsultProvider(this._createAppointmentOrderUseCase, this._userData);

  int currentMinute;
  List<Widget> dateReserveList;
  TimeSlotModel timeSlotModel;
  SlotModel slotModel;

  Future<void> callServiceCreateAppointmentOrder(BuildContext context,
      DoctorInfoModel doctorInfoModel, AvailableSlotModel availableSlotModel) async {
    showProgressDialog(context);
    final requestModel = CreateAppointmentOrderModel(
        doctorInfoModel.doctorId,
        _userData.userProfileModel.userUID,
        availableSlotModel.id,
        timeSlotModel.id,
        slotModel.id);
    final result = await _createAppointmentOrderUseCase.execute(BaseRequestModel<CreateAppointmentOrderModel>(requestModel));
    result.whenWithResult((data) {
      Navigator.pop(context);
    }, (map) {
      Navigator.pop(context);
      errorHandle.proceed(context, map);
    });
  }
}
