import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/page/doctor_history/doctor_history_provider.dart';
import 'package:blossom_clinic/usecase/get_user_reference_from_local_storage_use_case.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:blossom_clinic/widget/appointment_item.dart';
import 'package:blossom_clinic/widget/doctor_history_segment_control.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class DoctorHistoryPage extends StatelessWidget {

  UserData _userData = Injector.appInstance.get();
  GetUserReferenceFromLocalStorageUseCase _getUserReferenceFromLocalStorageUseCase = Injector.appInstance.get();
  DoctorHistoryProvider _provider;

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
            DoctorHistorySegmentControl((index) {}),
            Expanded(
              child: Consumer<DoctorHistoryProvider>(builder: (BuildContext context, DoctorHistoryProvider value, Widget child) {
                if (value.list == null) {
                  return Container();
                } else {
                  if (value.list is List<AppointmentModel>) {
                    return ListView.builder(
                      itemCount: value.list?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                      return AppointmentItem(value.list[index] as AppointmentModel, _getUserReferenceFromLocalStorageUseCase);
                    },);
                  } else {
                    return Container();
                  }
                }
              },),
            )
          ],
        ),
      ),
    );
  }
}
