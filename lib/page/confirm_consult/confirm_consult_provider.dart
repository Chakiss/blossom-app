import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/doctor_time_model.dart';
import 'package:blossom_clinic/model/response/get_doctor_min_consult_response_model.dart';
import 'package:blossom_clinic/widget/consult_doctor_day_item.dart';
import 'package:blossom_clinic/widget/doctor_duration_choice.dart';
import 'package:flutter/material.dart';

class ConfirmConsultProvider extends BaseProvider with ChangeNotifier {
  DoctorDurationChoice doctorDurationChoice;
  GetDoctorMinConsultResponseModel doctorMin;
  int currentMinute;
  List<Widget> dateReserveList;
  DoctorTimeModel doctorTimeModel;
  var selectedIndex = -1;

  Future<void> callServiceGetDoctorMinConsult(BuildContext context, int doctorId, String dateTime) async {
    final result = await remoteRepository.getDoctorMinConsult();
    result.whenWithResult((data) {
      if (data?.data != null) {
        doctorDurationChoice = DoctorDurationChoice(
            list: data?.data,
            listener: (value) {
              doctorMin = value;
              doctorTimeModel = null;
              currentMinute = value.quota;
              callServiceGetDoctorTimeReserve(context, doctorId.toString(), dateTime, currentMinute);
            });
        notifyListeners();
      }
    }, (statusModel) {
      errorHandle.proceed(context, statusModel);
    });
  }

  Future<void> callServiceGetDoctorTimeReserve(BuildContext context, String doctorId, String date, int minute) async {
    selectedIndex = -1;
    final result = await remoteRepository.getDoctorTimeReserve(doctorId, date, minute);
    result.whenWithResult((data) {
      dateReserveList = _generateTimeReserveItem(data.data.timeList);
      notifyListeners();
    }, (statusModel) {
      errorHandle.proceed(context, statusModel);
    });
  }

  List<Widget> _generateTimeReserveItem(List<DoctorTimeModel> timeReserveListData) {
    List<Widget> list = [];
    timeReserveListData.asMap().forEach((index, element) {
      list.add(ConsultDoctorDayItem<DoctorTimeModel>(
        "${element?.start ?? ""} ${element?.unit ?? "น."}",
        element,
        true,
        (timeReserve) {
          print("Test Item Click $index");
          selectedIndex = index;
          dateReserveList = _generateTimeReserveItem(timeReserveListData);
          doctorTimeModel = timeReserve;
          notifyListeners();
        },
        index: index,
        selectedIndex: selectedIndex,
      ));
    });
    return list;
  }
}
