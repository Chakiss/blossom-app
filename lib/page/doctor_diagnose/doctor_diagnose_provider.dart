import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/request/create_shipnity_customer_request_model.dart';
import 'package:blossom_clinic/model/shipnity_customer_model.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/network/service_properties.dart';
import 'package:blossom_clinic/usecase/create_shipnity_customer_use_case.dart';
import 'package:blossom_clinic/usecase/get_shipnity_customer_use_case.dart';
import 'package:blossom_clinic/usecase/get_user_profile_with_connecty_cube_id_use_case.dart';
import 'package:flutter/material.dart';

class DoctorDiagnoseProvider extends BaseProvider with ChangeNotifier {

  String skinType;
  String acneTypes;
  GetUserProfileWithConnectyCubeIdUseCase _getUserProfileWithConnectyCubeIdUseCase;
  GetShipnityCustomerUseCase _getShipnityCustomerUseCase;
  CreateShipnityCustomerUseCase _createShipnityCustomerUseCase;

  UserProfileModel userProfileModel;
  ShipnityCustomerModel shipnityCustomerModel;


  DoctorDiagnoseProvider(this._getUserProfileWithConnectyCubeIdUseCase, this._getShipnityCustomerUseCase, this._createShipnityCustomerUseCase);

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
    final result = await _getShipnityCustomerUseCase.execute(
      {
       "token": ServiceProperties.SHIPNITY_TOKEN,
       "phoneNumber": userProfileModel.phoneNumber.convertPhoneNumberWithoutCountryCode()
      }
    );
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
    final result = await _createShipnityCustomerUseCase.execute(
        {
          "token": ServiceProperties.SHIPNITY_TOKEN,
          "requestModel": CreateShipnityCustomerRequestModel(CreateShipnityCustomer(
            name: "${userProfileModel.firstName ?? ""} ${userProfileModel.lastName ?? ""}",
            address: "",
            tel: userProfileModel.phoneNumber.convertPhoneNumberWithoutCountryCode(),
            contact_method: "blossom_app",
            email: userProfileModel.email ?? "",
            tag: "blossom_app"
          ))
        }
    );
    result.whenWithResult((data) {
      shipnityCustomerModel = data;
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }
}