import 'package:blossom_clinic/base/base_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/base_model.dart';
import 'package:blossom_clinic/model/request/sign_in_request_model.dart';
import 'package:blossom_clinic/model/response/get_profile_response_model.dart';
import 'package:blossom_clinic/model/response/sign_in_facebook_response_model.dart';
import 'package:blossom_clinic/model/status_model.dart';
import 'package:blossom_clinic/model/user_model.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';

class LoginUseCase extends BaseUseCase<SignInRequestModel, GetProfileResponseModel> {
  RemoteRepository _remoteRepository;
  UserModel _userModel;

  LoginUseCase(this._remoteRepository, this._userModel);

  @override
  Future<Result<GetProfileResponseModel>> execute(SignInRequestModel parameter) async {
    try {
      final signInResult = await _callServiceSignIn(parameter);
      if (signInResult is Error) {
        final statusModel = (signInResult as Error).statusModel;
        return Error<GetProfileResponseModel>(statusModel);
      }
      final getProfileResult = await _callServiceGetProfile();
      return getProfileResult;
    } catch (exception) {
      return Error<GetProfileResponseModel>(StatusModel("9999", "E", "Not login"));
    }
  }

  Future<Result<BaseModel<SignInResponseModel>>> _callServiceSignIn(SignInRequestModel signInRequestModel) async {
    final result = await _remoteRepository.signIn(signInRequestModel);
    if (result is Success<BaseModel<SignInResponseModel>>) {
      final data = result;
      _userModel.signInResponseModel = (data).data.data;
    }
    return result;
  }

  Future<Result<GetProfileResponseModel>> _callServiceGetProfile() async {
    final result = await _remoteRepository.getProfile(_userModel.getBearerToken());
    if (result is Success<GetProfileResponseModel>) {
      _userModel.profileResponseModel = result.data;
    }
    return result;
  }
}
