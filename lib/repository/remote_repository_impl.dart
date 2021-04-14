import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/base_model.dart';
import 'package:blossom_clinic/model/base_model_list.dart';
import 'package:blossom_clinic/model/request/add_card_request_model.dart';
import 'package:blossom_clinic/model/request/booking_consult_doctor_request_model.dart';
import 'package:blossom_clinic/model/request/end_video_conference_request_model.dart';
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
import 'package:blossom_clinic/model/status_model.dart';
import 'package:blossom_clinic/network/retrofit_client.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';

class RemoteRepositoryImpl extends RemoteRepository {
  final RetrofitClient retrofitClient;

  RemoteRepositoryImpl({this.retrofitClient});

  @override
  Future<Result<SignInFacebookResponseModel>> signInWithFacebook(SignInFacebookRequestModel requestModel) async {
    try {
      final _response = await retrofitClient.signInWithFacebook(requestModel);
      if (_response.status.resType == "S") {
        return Success(_response.data);
      } else {
        return Error(_response.status);
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  @override
  Future<Result<List<PackageResponseModel>>> getPackage(String token) async {
    try {
      final _response = await retrofitClient.getPackage(token);
      if (_response.status.resType == "S") {
        return Success(_response.data);
      } else {
        return Error(_response.status);
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  @override
  Future<Result<GetProfileResponseModel>> getProfile(String token) async {
    try {
      final _response = await retrofitClient.getProfile(token);
      if (_response.status.resType == "S") {
        return Success(_response.data);
      } else {
        return Error(_response.status);
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  @override
  Future<Result<BaseModel<BuyPackResponseModel>>> buyPackage(String token, String packId) async {
    try {
      final _response = await retrofitClient.buyPackage(token, packId);
      if (_response.status.resType == "S") {
        return Success(_response);
      } else {
        return Error(_response.status);
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  @override
  Future<Result<BaseModel<GetSourceDestinationResponseModel>>> getSourceDestination(
      String token, String sourceCubeId) async {
    try {
      final _response = await retrofitClient.getSourceDestination(token, sourceCubeId);
      if (_response.status.resType == "S") {
        return Success(_response);
      } else {
        return Error(_response.status);
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  @override
  Future<Result<StartVideoCallResponseModel>> startVideoCall(String token, StartVideoConferenceRequestModel requestModel) async {
    try {
      final _response = await retrofitClient.startVideoCall(token, requestModel);
      if (_response.status.resType == "S") {
        return Success(_response);
      } else {
        return Error(_response.status);
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  @override
  Future<Result<EndVideoCallResponseModel>> endVideoCall(String token, EndVideoConferenceRequestModel requestModel) async {
    try {
      final _response = await retrofitClient.endVideoCall(token, requestModel);
      if (_response.status.resType == "S") {
        return Success(_response);
      } else {
        return Error(_response.status);
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  BaseModelList<DoctorInfo> doctorListCache;
  @override
  Future<Result<List<DoctorInfo>>> getDoctorList() async {
    try {
      if (doctorListCache == null) {
        doctorListCache = await retrofitClient.getDoctorList();
      }
      if (doctorListCache.status.resType == "S") {
        return Success(doctorListCache.data);
      } else {
        return Error(doctorListCache.status);
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  @override
  Future<Result<BaseModel<GetDoctorDateReserveResponseModel>>> getDoctorDateReserve(String doctorId) async {
    try {
      final _response = await retrofitClient.getDoctorDateReserve(doctorId);
      if (_response.status.resType == "S") {
        return Success(_response);
      } else {
        return Error(_response.status);
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  BaseModelList<GetDoctorMinConsultResponseModel> doctorMinCache;
  @override
  Future<Result<BaseModelList<GetDoctorMinConsultResponseModel>>> getDoctorMinConsult() async {
    try {
      if (doctorMinCache == null) {
        doctorMinCache = await retrofitClient.getDoctorMinConsult();
      }
      if (doctorMinCache.status.resType == "S") {
        return Success(doctorMinCache);
      } else {
        return Error(doctorMinCache.status);
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  @override
  Future<Result<BaseModel<GetDoctorTimeReserveResponseModel>>> getDoctorTimeReserve(String doctorId, String date, int minute) async {
    try {
      final _response = await retrofitClient.getDoctorTimeReserve(doctorId, date, minute);
      if (_response.status.resType == "S") {
        return Success(_response);
      } else {
        return Error(_response.status);
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  @override
  Future<Result<BaseModel<BookingConsultDoctorResponseModel>>> bookingConsultDoctor(String token, BookingConsultDoctorRequestModel requestModel) async {
    try {
      final _response = await retrofitClient.bookingConsultDoctor(token, requestModel);
      if (_response.status.resType == "S") {
        return Success(_response);
      } else {
        return Error(_response.status);
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  @override
  Future<Result<AddCardResponseModel>> addCard(String token, AddCardRequestModel requestModel) async {
    try {
      final _response = await retrofitClient.addCard(token, requestModel);
      if (_response.status.resType == "S") {
        return Success(_response);
      } else {
        return Error(_response.status);
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  @override
  Future<Result<BaseModelList<GetBookingHistoryResponseModel>>> getBookingHistory(String token) async {
    try {
      final _response = await retrofitClient.getBookingHistory(token);
      if (_response.status.resType == "S") {
        return Success(_response);
      } else {
        return Error(_response.status);
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }
}
