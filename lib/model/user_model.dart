import 'dart:convert';

import 'package:blossom_clinic/model/response/get_profile_response_model.dart';
import 'package:blossom_clinic/model/response/sign_in_facebook_response_model.dart';

class UserModel {
  String facebookId;
  String email;
  String profilePath;
  SignInFacebookResponseModel signInFacebookResponseModel;
  GetProfileResponseModel profileResponseModel;

  UserModel({this.facebookId, this.email, this.profilePath, this.signInFacebookResponseModel, this.profileResponseModel});

  String getBearerToken() => "Bearer ${signInFacebookResponseModel?.token ?? ""}";

  String getBasicToken() => "Basic ${base64Encode(utf8.encode('skey_test_5n0xzn4kpsvxizlhvox'))}";

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      facebookId: json["facebookId"],
      email: json["email"],
      profilePath: json["profilePath"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "facebookId": facebookId,
      "email": email
    };
  }

  void setFromUserModel(UserModel userModel) {
    this.facebookId = userModel.facebookId ?? "";
    this.email = userModel.email ?? "";
  }
}
