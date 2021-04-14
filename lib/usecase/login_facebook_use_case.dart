import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/request/sign_in_facebook_request_model.dart';
import 'package:blossom_clinic/model/response/get_profile_response_model.dart';
import 'package:blossom_clinic/model/response/sign_in_response_model.dart';
import 'package:blossom_clinic/model/status_model.dart';
import 'package:blossom_clinic/model/user_model.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginFacebookUseCase {

  RemoteRepository _remoteRepository;
  UserModel _userModel;

  LoginFacebookUseCase(this._remoteRepository, this._userModel);

  Future<Result<GetProfileResponseModel>> execute(BuildContext context, FacebookAuth facebookAuth) async {
    try {
      final userData = await facebookAuth.getUserData();
      if (userData != null) {
        _userModel.profilePath = userData["picture"]["data"]["url"];
        final signInFacebookResult = await _callServiceSignInWithFacebook(context, userData);
        if (signInFacebookResult is Error) {
          final statusModel = (signInFacebookResult as Error).statusModel;
          return Error<GetProfileResponseModel>(statusModel);
        }
        final getProfileResult = await _callServiceGetProfile(context);
        return getProfileResult;
      } else {
        return Error<GetProfileResponseModel>(StatusModel("9999", "E", "Not login"));
      }
    } catch (exception) {
      return Error<GetProfileResponseModel>(StatusModel("9999", "E", "Not login"));
    }
  }

  Future<Result<SignInResponseModel>> _callServiceSignInWithFacebook(
      BuildContext context, Map<String, dynamic> userData) async {
    final requestModel = SignInFacebookRequestModel(
        facebookId: userData["id"], email: userData["email"], firstName: userData["name"], lastName: "", cubeToken: "");
    final result = await _remoteRepository.signInWithFacebook(requestModel);
    if (result is Success<SignInResponseModel>) {
      final data = result.data;
      _userModel.facebookId = requestModel.facebookId;
      _userModel.email = requestModel.email;
      _userModel.signInResponseModel = data;
    }
    return result;
  }

  Future<Result<GetProfileResponseModel>> _callServiceGetProfile(BuildContext context) async {
    final result = await _remoteRepository.getProfile(_userModel.getBearerToken());
    if (result is Success<GetProfileResponseModel>) {
      _userModel.profileResponseModel = result.data;
    }
    return result;
  }
}
