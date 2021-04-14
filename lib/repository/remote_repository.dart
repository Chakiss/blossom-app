import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/base_model.dart';
import 'package:blossom_clinic/model/base_model_list.dart';
import 'package:blossom_clinic/model/request/add_card_request_model.dart';
import 'package:blossom_clinic/model/request/booking_consult_doctor_request_model.dart';
import 'package:blossom_clinic/model/request/end_video_conference_request_model.dart';
import 'package:blossom_clinic/model/request/sign_in_request_model.dart';
import 'package:blossom_clinic/model/request/start_video_conference_request_model.dart';
import 'package:blossom_clinic/model/request/sign_in_facebook_request_model.dart';
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

abstract class RemoteRepository {
  Future<Result<BaseModel<SignInResponseModel>>> signIn(SignInRequestModel requestModel);

  Future<Result<SignInResponseModel>> signInWithFacebook(SignInFacebookRequestModel requestModel);

  Future<Result<List<PackageResponseModel>>> getPackage(String token);

  Future<Result<GetProfileResponseModel>> getProfile(String token);

  Future<Result<BaseModel<BuyPackResponseModel>>> buyPackage(String token, String packId);

  Future<Result<BaseModel<GetSourceDestinationResponseModel>>> getSourceDestination(String token, String sourceCubeId);

  Future<Result<StartVideoCallResponseModel>> startVideoCall(
      String token, StartVideoConferenceRequestModel requestModel);

  Future<Result<EndVideoCallResponseModel>> endVideoCall(String token, EndVideoConferenceRequestModel requestModel);

  Future<Result<List<DoctorInfo>>> getDoctorList();

  Future<Result<BaseModel<GetDoctorDateReserveResponseModel>>> getDoctorDateReserve(String doctorId);

  Future<Result<BaseModelList<GetDoctorMinConsultResponseModel>>> getDoctorMinConsult();

  Future<Result<BaseModel<GetDoctorTimeReserveResponseModel>>> getDoctorTimeReserve(
      String doctorId, String date, int minute);

  Future<Result<BaseModel<BookingConsultDoctorResponseModel>>> bookingConsultDoctor(String token,
      BookingConsultDoctorRequestModel requestModel);

  Future<Result<AddCardResponseModel>> addCard(String token,
      AddCardRequestModel requestModel);

  Future<Result<BaseModelList<GetBookingHistoryResponseModel>>> getBookingHistory(String token);
}
