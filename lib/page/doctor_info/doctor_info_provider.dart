import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/date_reserve_model.dart';
import 'package:blossom_clinic/widget/consult_doctor_day_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorInfoProvider extends BaseProvider with ChangeNotifier {

    List<Widget> dateReserveList;
    DateReserveModel dateReserveModel;
    var selectedIndex = -1;

    Future<void> callServiceGetDoctorDateReserve(BuildContext context, int doctorId) async {
      final result =  await remoteRepository.getDoctorDateReserve(doctorId.toString());
      result.whenWithResult((data) {
        dateReserveList = _generateDateReserveItem(data.data.dateList);
        notifyListeners();
      }, (statusModel) {
        errorHandle.proceed(context, statusModel);
      });
    }

    List<Widget> _generateDateReserveItem(List<DateReserveModel> dateReserveListData) {
      final dateFormat = DateFormat("d MMM", "TH");
      List<Widget> list = [];
      dateReserveListData.asMap().forEach((index, element) {
        final title = dateFormat.format(DateTime.parse(element.date));
        if (element.foundDateFlag.toLowerCase() == "y") {
          list.add(ConsultDoctorDayItem<DateReserveModel>(title, element, true, (dateReserve) {
            print("Test Item Click $index");
            selectedIndex = index;
            dateReserveList = _generateDateReserveItem(dateReserveListData);
            dateReserveModel = dateReserve;
            notifyListeners();
          }, index: index, selectedIndex: selectedIndex,));
        } else {
          list.add(ConsultDoctorDayItem<DateReserveModel>(title, element, false, (dateReserve) {

          }, index: index, selectedIndex: selectedIndex,));
        }
      });
      return list;
    }
}
