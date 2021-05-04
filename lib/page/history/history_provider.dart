import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/shipnity_order_model.dart';
import 'package:blossom_clinic/network/service_properties.dart';
import 'package:blossom_clinic/usecase/get_appointment_by_user_id_use_case.dart';
import 'package:blossom_clinic/usecase/get_shipnity_order_list_by_phone_number_use_case.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:flutter/material.dart';

class HistoryProvider extends BaseProvider with ChangeNotifier {

  GetAppointmentByUserIdUseCase _getAppointmentByUserIdUseCase;
  GetShipnityOrderListByPhoneNumberUseCase _getShipnityOrderListByPhoneNumberUseCase;
  UserData _userData;
  int selectedIndex = 0;
  List<AppointmentModel> appointmentList;
  List<ShipnityOrderModel> orderList;

  HistoryProvider(this._getAppointmentByUserIdUseCase, this._getShipnityOrderListByPhoneNumberUseCase, this._userData);

  Future<void> getAppointmentList(BuildContext context) async {
    final result = await _getAppointmentByUserIdUseCase.execute(_userData.userProfileModel.userUID);
    result.whenWithResult((data) {
      appointmentList = data;
      notifyListeners();
    }, (map) {
      // errorHandle.proceed(context, map);
    });
  }

  Future<void> _getShipnityOrderListByPhoneNumber(BuildContext context) async {
    final result = await _getShipnityOrderListByPhoneNumberUseCase.execute({
      "token": ServiceProperties.SHIPNITY_TOKEN,
      "phoneNumber": _userData.userProfileModel.phoneNumber.convertPhoneNumberWithoutCountryCode()
    });
    result.whenWithResult((data) {
      orderList = data;
      notifyListeners();
    }, (map) {
      // errorHandle.proceed(context, map);
    });
  }

  void setSelectedIndex(BuildContext context, int index) {
    this.selectedIndex = index;
    notifyListeners();
    if (orderList == null) {
      _getShipnityOrderListByPhoneNumber(context);
    }
  }
}