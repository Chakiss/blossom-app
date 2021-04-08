class SignInFacebookResponseModel {

  String token;
  String role;
  String profileImg;
  String firstName;
  String lastName;

  SignInFacebookResponseModel({this.token, this.role, this.profileImg, this.firstName, this.lastName});

  factory SignInFacebookResponseModel.fromJson(Map<String, dynamic> json) {
    return SignInFacebookResponseModel(
      token: json["token"],
      role: json["role"],
      profileImg: json["profileImg"],
      firstName: json["firstName"],
      lastName: json["lastName"]
    );
  }

  // Map<String, dynamic> toJson() {
  // return {
  //     'token': token,
  //     'role': role,
  //     'profileImg': profileImg,
  //     'firstName': firstName,
  //     'lastName': lastName
  //   };
  // }
}
