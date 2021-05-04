import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/page/doctor_history/doctor_history_provider.dart';
import 'package:blossom_clinic/usecase/set_user_reference_to_local_storage_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:blossom_clinic/widget/appointment_item.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DoctorHistoryPage extends StatelessWidget {
  UserData _userData = Injector.appInstance.get();
  SharedPrefUtils _sharedPrefUtils = Injector.appInstance.get();
  SetUserReferenceToLocalStorageUseCase _setUserReferenceFromLocalStorageUseCase = Injector.appInstance.get();
  DoctorHistoryProvider _provider;
  DateFormat _dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateFormat _dateFormatParse = DateFormat("d MMMM yyyy เวลา HH:mm", "TH");

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.getAppointmentByDoctorId(context, _userData.doctorInfoModel.doctorId);
    return BaseScreen(
      child: Container(
        child: Column(
          children: [
            Toolbar(
              title: "รายการ",
            ),
            SizedBox(
              height: 26,
            ),
            // DoctorHistorySegmentControl((index) {}),
            Expanded(
              child: Consumer<DoctorHistoryProvider>(
                builder: (BuildContext context, DoctorHistoryProvider value, Widget child) {
                  if (value.list == null) {
                    return Container(
                        child: Center(
                          child: BlossomProgressIndicator(),
                        ));
                  } else {
                    if (value.list is List<AppointmentModel>) {
                      return ListView.builder(
                        itemCount: value.list?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return AppointmentItem(value.list[index] as AppointmentModel, _sharedPrefUtils,
                              _setUserReferenceFromLocalStorageUseCase, (appointmentModel, name, appointmentTime) {
                                Navigator.push(context, RouteManager.routeDoctorAppointmentDetail(appointmentModel, name, appointmentTime));
                              }, dateFormat: _dateFormat, dateFormatParse: _dateFormatParse,);
                        },);
                    } else {
                      return Container();
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
