import 'dart:convert';

import 'package:blossom_clinic/model/base_model.dart';
import 'package:blossom_clinic/model/base_model_list.dart';
import 'package:blossom_clinic/model/request/add_card_request_model.dart';
import 'package:blossom_clinic/model/request/booking_consult_doctor_request_model.dart';
import 'package:blossom_clinic/model/request/end_video_conference_request_model.dart';
import 'package:blossom_clinic/model/request/sign_in_facebook_request_model.dart';
import 'package:blossom_clinic/model/request/start_video_conference_request_model.dart';
import 'package:blossom_clinic/model/response/GetDoctorTimeReserveResponseModel.dart';
import 'package:blossom_clinic/model/response/add_card_response_model.dart';
import 'package:blossom_clinic/model/response/booking_consult_doctor_response_model.dart';
import 'package:blossom_clinic/model/response/buy_pack_response_model.dart';
import 'package:blossom_clinic/model/response/doctor_info.dart';
import 'package:blossom_clinic/model/response/end_video_call_response_model.dart';
import 'package:blossom_clinic/model/response/get_book_history_response_model.dart';
import 'package:blossom_clinic/model/response/get_doctor_date_reserve_response_model.dart';
import 'package:blossom_clinic/model/response/get_doctor_min_consult_response_model.dart';
import 'package:blossom_clinic/model/response/get_profile_response_model.dart';
import 'package:blossom_clinic/model/response/get_soruce_destination_response_model.dart';
import 'package:blossom_clinic/model/response/package_response_model.dart';
import 'package:blossom_clinic/model/response/sign_in_facebook_response_model.dart';
import 'package:blossom_clinic/model/response/start_video_call_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'retrofit_client.g.dart';

@RestApi(baseUrl: "https://apitest.blossom-app.com/blossomapi/")
// @RestApi(baseUrl: "https://api.blossom-app.com/blossomapi/")
abstract class RetrofitClient {
  factory RetrofitClient(Dio dio, {String baseUrl}) = _RetrofitClient;

  @POST("auth/v1.0.0/signInWithFacebook")
  Future<BaseModel<SignInFacebookResponseModel>> signInWithFacebook(@Body() SignInFacebookRequestModel requestModel);

  @GET("package/v1.0.0/videoCon?packCode=1")
  Future<BaseModelList<PackageResponseModel>> getPackage(@Header("Authorization") String token);

  @GET("user/v1.0.0/profile")
  Future<BaseModel<GetProfileResponseModel>> getProfile(@Header("Authorization") String token);

  @POST("package/v2.0.0/videoCon")
  Future<BaseModel<BuyPackResponseModel>> buyPackage(
      @Header("Authorization") token, @Query("packCode") String packCode);

  @GET("videoCon/v1.0.0/getSourceDesc")
  Future<BaseModel<GetSourceDestinationResponseModel>> getSourceDestination(
      @Header("Authorization") token, @Query("sourceCubeId") String sourceCubeId);

  @POST("videoCon/v1.0.0/startVideoCon")
  Future<StartVideoCallResponseModel> startVideoCall(
      @Header("Authorization") token, @Body() StartVideoConferenceRequestModel requestModel);

  @POST("videoCon/v1.0.0/endVideoCon")
  Future<EndVideoCallResponseModel> endVideoCall(
      @Header("Authorization") token, @Body() EndVideoConferenceRequestModel requestModel);

  @GET("doctorInfo/v1.0.0/getDoctorsInfo")
  Future<BaseModelList<DoctorInfo>> getDoctorList();

  @GET("doctorInfo/v1.0.0/getDoctorDateReserve")
  Future<BaseModel<GetDoctorDateReserveResponseModel>> getDoctorDateReserve(@Query("doctorId") String doctorId);

  @GET("doctorInfo/v1.0.0/getDoctorMinConsult")
  Future<BaseModelList<GetDoctorMinConsultResponseModel>> getDoctorMinConsult();

  @GET("doctorInfo/v1.0.0/getDoctorTimeReserve")
  Future<BaseModel<GetDoctorTimeReserveResponseModel>> getDoctorTimeReserve(
      @Query("doctorId") String doctorId, @Query("date") String date, @Query("minute") int minute);

  @POST("booking/v1.0.0/videoCon")
  Future<BaseModel<BookingConsultDoctorResponseModel>> bookingConsultDoctor(
      @Header("Authorization") String token, @Body() BookingConsultDoctorRequestModel requestModel);

  @POST("payment/v1.0.0/card")
  Future<AddCardResponseModel> addCard(
      @Header("Authorization") String token, @Body() AddCardRequestModel requestModel);

  @GET("booking/v1.0.0/getBookingHistory")
  Future<BaseModelList<GetBookingHistoryResponseModel>> getBookingHistory(
      @Header("Authorization") String token);
}
