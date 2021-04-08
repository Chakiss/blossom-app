import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/base_model.dart';
import 'package:blossom_clinic/model/request/end_video_conference_request_model.dart';
import 'package:blossom_clinic/model/request/start_video_conference_request_model.dart';
import 'package:blossom_clinic/model/request/sign_in_facebook_request_model.dart';
import 'package:blossom_clinic/model/response/buy_pack_response_model.dart';
import 'package:blossom_clinic/model/response/end_video_call_response_model.dart';
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
      if (_response.status.resType == "S" || _response.status.resType == "B") {
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
}
