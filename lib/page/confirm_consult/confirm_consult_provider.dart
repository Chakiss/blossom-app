import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/doctor/doctor_provider.dart';
import 'package:blossom_clinic/model/available_slot_model.dart';
import 'package:blossom_clinic/model/doctor_info_model.dart';
import 'package:blossom_clinic/model/request/create_appointment_order_model.dart';
import 'package:blossom_clinic/model/slot_model.dart';
import 'package:blossom_clinic/model/time_slot_model.dart';
import 'package:blossom_clinic/page/history/history_provider.dart';
import 'package:blossom_clinic/page/login/login_provider.dart';
import 'package:blossom_clinic/page/main/main_page.dart';
import 'package:blossom_clinic/page/main/main_provider.dart';
import 'package:blossom_clinic/page/profile/profile_provider.dart';
import 'package:blossom_clinic/page/service/service_provider.dart';
import 'package:blossom_clinic/usecase/create_appointment_order_use_case.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

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
    final result = await _createAppointmentOrderUseCase.execute(requestModel);
    result.whenWithResult((data) {
      Navigator.pop(context);
      showToast("การจองคิวสำเร็จ");
      goToMainPage(context);
    }, (map) {
      Navigator.pop(context);
      errorHandle.proceed(context, map);
    });
  }

  void goToMainPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) => MainProvider(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => DoctorProvider(Injector.appInstance.get()),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => HistoryProvider(Injector.appInstance.get(), Injector.appInstance.get()),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => ServiceProvider(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => LoginProvider(Injector.appInstance.get(), Injector.appInstance.get(), FirebaseAuth.instance),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => ProfileProvider(),
          ),
        ],
        child: MainPage(),
      );
    }), (route) => false);
  }
}
