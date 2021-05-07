class DoctorInfoModel {

  DateTime createdAt;
  String displayName;
  String displayPhoto;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  int referenceConnectyCubeID;
  String story;
  DateTime updatedAt;
  String doctorId;

  DoctorInfoModel({this.createdAt, this.displayName, this.displayPhoto, this.email, this.firstName, this.lastName,
      this.phoneNumber, this.referenceConnectyCubeID, this.story, this.updatedAt, this.doctorId});

  factory DoctorInfoModel.fromJson(String id, Map<String, dynamic> json) {
    return DoctorInfoModel(
        doctorId: id,
        createdAt: json["createdAt"].toDate(),
        displayName: json["displayName"],
        displayPhoto: json["displayPhoto"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        referenceConnectyCubeID: json["referenceConnectyCubeID"],
        story: json["story"],
        updatedAt: json["updatedAt"].toDate());
  }
}