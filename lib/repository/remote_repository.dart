import 'package:blossom_clinic/model/base/base_request_model.dart';
import 'package:blossom_clinic/model/request/create_appointment_order_model.dart';
import 'package:blossom_clinic/model/request/create_new_application_user_request_model.dart';
import 'package:blossom_clinic/model/response/create_appointment_order_response_model.dart';
import 'package:blossom_clinic/model/response/register_response_model.dart';

abstract class RemoteRepository {

  Future<RegisterResponseModel> register(CreateNewApplicationUserRequestModel requestModel);

  Future<CreateAppointmentOrderResponseModel> createAppointmentOrder(BaseRequestModel<CreateAppointmentOrderModel> requestModel);
}
