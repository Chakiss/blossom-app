import 'dart:convert';

import 'package:blossom_clinic/model/response/get_profile_response_model.dart';

class UserModel {
  String role;
  String token;
  String firstName;
  String profileUrl;
  String facebookId;
  String email;
  GetProfileResponseModel profileResponseModel;

  UserModel({this.role, this.token, this.firstName, this.profileUrl, this.facebookId, this.profileResponseModel, this.email});

  String getBearerToken() => "Bearer $token";

  String getBasicToken() => "Basic ${base64Encode(utf8.encode('skey_test_5n0xzn4kpsvxizlhvox'))}";

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      role: json["role"],
      token: json["token"],
      firstName: json["firstName"],
      profileUrl: json["profileUrl"],
      facebookId: json["facebookId"],
      email: json["email"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "role": role,
      "token": token,
      "firstName": firstName,
      "profileUrl": profileUrl,
      "facebookId": facebookId,
      "email": email
    };
  }

  void setFromUserModel(UserModel userModel) {
    this.role = userModel.role ?? "";
    this.token = userModel.token ?? "";
    this.firstName = userModel.firstName ?? "";
    this.profileUrl = userModel.profileUrl ?? "";
    this.facebookId = userModel.facebookId ?? "";
    this.email = userModel.email ?? "";
  }
}
