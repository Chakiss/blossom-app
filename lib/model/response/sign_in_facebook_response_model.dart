class SignInResponseModel {

  String token;
  String role;
  String profileImg;
  String firstName;
  String lastName;

  SignInResponseModel({this.token, this.role, this.profileImg, this.firstName, this.lastName});

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) {
    return SignInResponseModel(
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
