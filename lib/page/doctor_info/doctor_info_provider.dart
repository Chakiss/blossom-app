import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/available_slot_model.dart';
import 'package:blossom_clinic/usecase/get_doctor_available_slots_use_case.dart';
import 'package:blossom_clinic/widget/consult_doctor_day_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorInfoProvider extends BaseProvider with ChangeNotifier {
  GetDoctorAvailableSlotsUseCase _getDoctorAvailableSlotsUseCase;

  DoctorInfoProvider(this._getDoctorAvailableSlotsUseCase);

  List<ConsultDoctorDayItem> list;
  AvailableSlotModel availableSlotModel;
  DateTime selectedDate = DateTime.now();

  Future<void> getDoctorAvailableSlots(BuildContext context, String doctorId) async {
    final result = await _getDoctorAvailableSlotsUseCase.execute(doctorId);
    result.whenWithResult((data) {
      _generateConsultDoctorDayList(data);
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }

  void _generateConsultDoctorDayList(List<AvailableSlotModel> data) {
    final dateFormat = DateFormat("dd MMM", "TH");
    list = data
        .map((e) => ConsultDoctorDayItem(
              e,
              dateFormat.format(e.date),
              (value) {
                selectedDate = value.date;
                availableSlotModel = value;
                _generateConsultDoctorDayList(data);
              },
              selectedDate: selectedDate,
            ))
        .toList();
    notifyListeners();
  }
}
