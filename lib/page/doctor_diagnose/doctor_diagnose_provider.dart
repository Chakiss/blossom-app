import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/request/create_shipnity_customer_request_model.dart';
import 'package:blossom_clinic/model/request/save_doctor_diagnose_request_model.dart';
import 'package:blossom_clinic/model/shipnity_customer_model.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/network/service_properties.dart';
import 'package:blossom_clinic/usecase/create_shipnity_customer_use_case.dart';
import 'package:blossom_clinic/usecase/get_shipnity_customer_use_case.dart';
import 'package:blossom_clinic/usecase/get_user_profile_with_connecty_cube_id_use_case.dart';
import 'package:blossom_clinic/usecase/save_doctor_diagnose_form_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:flutter/material.dart';

class DoctorDiagnoseProvider extends BaseProvider with ChangeNotifier {
  GetUserProfileWithConnectyCubeIdUseCase _getUserProfileWithConnectyCubeIdUseCase;
  GetShipnityCustomerUseCase _getShipnityCustomerUseCase;
  CreateShipnityCustomerUseCase _createShipnityCustomerUseCase;
  SaveDoctorDiagnoseFormUseCase _saveDoctorDiagnoseFormUseCase;
  String _appointmentId;

  String skinType;
  String diagnose;
  String careRecommend;
  UserProfileModel userProfileModel;
  ShipnityCustomerModel shipnityCustomerModel;

  DoctorDiagnoseProvider(this._getUserProfileWithConnectyCubeIdUseCase, this._getShipnityCustomerUseCase,
      this._createShipnityCustomerUseCase, this._saveDoctorDiagnoseFormUseCase, this._appointmentId);

  Future<void> getUserProfile(BuildContext context, int connectCubeId) async {
    final result = await _getUserProfileWithConnectyCubeIdUseCase.execute(connectCubeId);
    result.whenWithResult((data) {
      userProfileModel = data;
      _getShipnityCustomer(context, data);
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }

  Future<void> _getShipnityCustomer(BuildContext context, UserProfileModel userProfileModel) async {
    final result = await _getShipnityCustomerUseCase.execute({
      "token": ServiceProperties.SHIPNITY_TOKEN,
      "phoneNumber": userProfileModel.phoneNumber.convertPhoneNumberWithoutCountryCode()
    });
    result.whenWithResult((data) {
      if (data == null) {
        _createShipnityCustomer(context, userProfileModel);
      } else {
        shipnityCustomerModel = data;
      }
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }

  Future<void> _createShipnityCustomer(BuildContext context, UserProfileModel userProfileModel) async {
    final result = await _createShipnityCustomerUseCase.execute({
      "token": ServiceProperties.SHIPNITY_TOKEN,
      "requestModel": CreateShipnityCustomerRequestModel(CreateShipnityCustomer(
          name: "${userProfileModel.firstName ?? ""} ${userProfileModel.lastName ?? ""}",
          address: "",
          tel: userProfileModel.phoneNumber.convertPhoneNumberWithoutCountryCode(),
          contact_method: "blossom_app",
          email: userProfileModel.email ?? "",
          tag: "app"))
    });
    result.whenWithResult((data) {
      shipnityCustomerModel = data;
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }

  Future<void> callSaveDoctorDiagnoseForm(BuildContext context, String acneOverview, String carePlan,
      String productRecommend, String nextAppointment) async {

    if (acneOverview?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณากรอกลักษณะสภาพผิว"});
      return;
    }

    if (skinType?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณาเลือกลักษณะผิว"});
      return;
    }

    if (diagnose?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณาเลือกวินิจฉัยโรค"});
      return;
    }

    if (carePlan?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณากรอกแผนการรักษา"});
      return;
    }

    if (careRecommend?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณาเลือกวินิจฉัยโรค"});
      return;
    }

    if (nextAppointment?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณากรอกนัดครั้งถัดไป"});
      return;
    }

    showProgressDialog(context);
    final requestModel = SaveDoctorDiagnoseRequestModel(
        appointmentID: _appointmentId,
        skinOverview: acneOverview,
        skinType: skinType,
        diagnoses: diagnose.substring(0, diagnose.length - 2),
        carePlan: carePlan,
        careRecommendation: careRecommend.substring(0, careRecommend.length - 2),
        productsRecommendation: productRecommend,
        nextAppointment: "$nextAppointment days");
    final result = await _saveDoctorDiagnoseFormUseCase.execute(requestModel);
    Navigator.pop(context);
    result.whenWithResult((data) {
      showToast("บันทึกคำวินิจฉัยสำเร็จ กรุณาเลือกยาที่ต้องการจ่ายให้ลูกค้า");
      _goToDispensePage(context);
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }

  void _goToDispensePage(BuildContext context) {
    Navigator.push(context, RouteManager.routeDispense(userProfileModel, shipnityCustomerModel, _appointmentId));
  }
}
