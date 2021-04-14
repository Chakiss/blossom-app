class SignInRequestModel {
  String userName;
  String password;

  SignInRequestModel(this.userName, this.password);

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "password": password
    };
  }
}