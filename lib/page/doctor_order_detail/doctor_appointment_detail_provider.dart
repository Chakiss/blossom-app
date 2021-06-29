import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/shipnity_order_model.dart';
import 'package:blossom_clinic/network/service_properties.dart';
import 'package:blossom_clinic/page/doctor_order_detail/appointment_customer_data_page.dart';
import 'package:blossom_clinic/page/doctor_order_detail/appointment_pre_page.dart';
import 'package:blossom_clinic/usecase/get_shipnity_order_by_invoice_id_use_case.dart';
import 'package:blossom_clinic/usecase/get_user_profile_by_id_use_case.dart';
import 'package:flutter/material.dart';

class DoctorAppointmentDetailProvider extends BaseProvider with ChangeNotifier {

  Widget page;
  GetShipnityOrderByInvoiceIdUseCase _getShipnityOrderByInvoiceIdUseCase;
  GetUserProfileByIdUseCase _getUserProfileByIdUseCase;
  ShipnityOrderModel shipnityOrderModel;
  String age = "-";
  String tel = "";

  DoctorAppointmentDetailProvider(this._getShipnityOrderByInvoiceIdUseCase, this._getUserProfileByIdUseCase);

  void initialPage(AppointmentModel appointmentModel) {
    page = AppointmentCustomerDataPage();
    notifyListeners();
  }

  void setPage(Widget page) {
    this.page = page;
    notifyListeners();
  }

  Future<void> callServiceGetShipnityOrderByInvoiceId(String invoiceId) async {
    final result = await _getShipnityOrderByInvoiceIdUseCase.execute({
      "token": ServiceProperties.SHIPNITY_TOKEN,
      "invoiceId": invoiceId
    });
    result.whenWithResult((data) {
      shipnityOrderModel = data;
      notifyListeners();
    }, (map) {

    });
  }

  Future<void> callServiceGetUserProfileById(AppointmentModel appointmentModel) async {
    final result = await _getUserProfileByIdUseCase.execute(appointmentModel.userReference.id);
    result.whenWithResult((data) {
      try {
        final year = (DateTime.now().difference(data.birthDate).inDays / 365).floor();
        age = "$year";
        tel = data.phoneNumber.convertPhoneNumberWithoutCountryCode();
        notifyListeners();
      } catch (e) {

      }
    }, (map) {

    });
  }
}