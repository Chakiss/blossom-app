class DoctorInfoModel {

  String createdAt;
  String displayName;
  String displayPhoto;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  String story;
  String updatedAt;

  DoctorInfoModel({this.createdAt, this.displayName, this.displayPhoto, this.email, this.firstName, this.lastName,
      this.phoneNumber, this.story, this.updatedAt});

  factory DoctorInfoModel.fromJson(Map<String, dynamic> json) {
    return DoctorInfoModel(
      createdAt: json["createdAt"],
      displayName: json["displayName"],
      displayPhoto: json["displayPhoto"],
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      phoneNumber: json["phoneNumber"],
      story: json["story"],
      updatedAt: json["updatedAt"],
    );
  }
}