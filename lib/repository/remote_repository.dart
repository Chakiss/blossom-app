import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/base_model.dart';
import 'package:blossom_clinic/model/request/end_video_conference_request_model.dart';
import 'package:blossom_clinic/model/request/start_video_conference_request_model.dart';
import 'package:blossom_clinic/model/request/sign_in_facebook_request_model.dart';
import 'package:blossom_clinic/model/response/buy_pack_response_model.dart';
import 'package:blossom_clinic/model/response/doctor_info.dart';
import 'package:blossom_clinic/model/response/end_video_call_response_model.dart';
import 'package:blossom_clinic/model/response/get_doctor_date_reserve_response_model.dart';
import 'package:blossom_clinic/model/response/get_profile_response_model.dart';
import 'package:blossom_clinic/model/response/get_soruce_destination_response_model.dart';
import 'package:blossom_clinic/model/response/package_response_model.dart';
import 'package:blossom_clinic/model/response/sign_in_facebook_response_model.dart';
import 'package:blossom_clinic/model/response/start_video_call_response_model.dart';

abstract class RemoteRepository {

  Future<Result<SignInFacebookResponseModel>> signInWithFacebook(SignInFacebookRequestModel requestModel);

  Future<Result<List<PackageResponseModel>>> getPackage(String token);

  Future<Result<GetProfileResponseModel>> getProfile(String token);

  Future<Result<BaseModel<BuyPackResponseModel>>> buyPackage(String token, String packId);

  Future<Result<BaseModel<GetSourceDestinationResponseModel>>> getSourceDestination(String token, String sourceCubeId);

  Future<Result<StartVideoCallResponseModel>> startVideoCall(String token, StartVideoConferenceRequestModel requestModel);

  Future<Result<EndVideoCallResponseModel>> endVideoCall(String token, EndVideoConferenceRequestModel requestModel);

  Future<Result<List<DoctorInfo>>> getDoctorList();

  Future<Result<BaseModel<GetDoctorDateReserveResponseModel>>> getDoctorDateReserve(String doctorId);
}