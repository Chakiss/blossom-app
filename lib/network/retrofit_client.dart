import 'package:blossom_clinic/model/base/base_request_model.dart';
import 'package:blossom_clinic/model/request/create_appointment_order_model.dart';
import 'package:blossom_clinic/model/request/create_new_application_user_request_model.dart';
import 'package:blossom_clinic/model/response/create_appointment_order_response_model.dart';
import 'package:blossom_clinic/model/response/register_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'retrofit_client.g.dart';

@RestApi(baseUrl: "https://us-central1-blossom-clinic-thailand.cloudfunctions.net/")
// @RestApi(baseUrl: "https://api.blossom-app.com/blossomapi/")
abstract class RetrofitClient {
  factory RetrofitClient(Dio dio, {String baseUrl}) = _RetrofitClient;

  @POST("/users-createNewApplicationUser")
  Future<RegisterResponseModel> createNewApplicationUser(@Body() CreateNewApplicationUserRequestModel requestModel);

  @POST("/orders-createAppointmentOrder")
  Future<CreateAppointmentOrderResponseModel> createAppointmentOrder(@Body() BaseRequestModel<CreateAppointmentOrderModel> requestModel);
}