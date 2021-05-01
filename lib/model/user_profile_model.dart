class UserProfileModel {
  String userUID;
  String acneCaredNoted;
  bool acneIsCared;
  List<int> acneTypes;
  DateTime birthDate;
  DateTime createdAt;
  List<String> drugAllergyItems;
  bool drugAllergyStatus;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  int referenceConnectyCubeID;
  String registeredChannel;
  String registeredNote;
  int skinType;
  DateTime updatedAt;

  UserProfileModel(
      {this.userUID,
      this.acneCaredNoted,
      this.acneIsCared,
      this.acneTypes,
      this.birthDate,
      this.createdAt,
      this.drugAllergyItems,
      this.drugAllergyStatus,
      this.email,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.referenceConnectyCubeID,
      this.registeredChannel,
      this.registeredNote,
      this.skinType,
      this.updatedAt});

  factory UserProfileModel.fromJson(String userId, Map<String, dynamic> json) {
    return UserProfileModel(
      userUID: userId,
      acneCaredNoted: json["acneCaredNoted"],
      acneIsCared: json["acneIsCared"],
      acneTypes: json["acneTypes"].cast<int>(),
      birthDate: json["birthDate"].toDate(),
      createdAt: json["createdAt"].toDate(),
      drugAllergyItems: json["drugAllergyItems"].cast<String>(),
      drugAllergyStatus: json["drugAllergyStatus"],
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      phoneNumber: json["phoneNumber"],
      referenceConnectyCubeID: json["referenceConnectyCubeID"],
      registeredChannel: json["registeredChannel"],
      registeredNote: json["registeredNote"],
      skinType: json["skinType"],
      updatedAt: json["updatedAt"].toDate(),
    );
  }
}
