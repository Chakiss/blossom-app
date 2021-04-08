import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SignInFacebookRequestModel {

  String facebookId;
  String email;
  String firstName;
  String lastName;
  String cubeToken;

  SignInFacebookRequestModel({this.facebookId, this.email, this.firstName, this.lastName, this.cubeToken});

  factory SignInFacebookRequestModel.fromJson(Map<String, dynamic> json) {
    return SignInFacebookRequestModel(
        facebookId: json["facebookId"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        cubeToken: json["cubeToken"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "facebookId" : facebookId,
      "email" : email,
      "firstName" : firstName,
      "lastName" : lastName,
      "cubeToken" : cubeToken
    };
  }
}