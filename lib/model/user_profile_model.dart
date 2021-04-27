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
      this.registeredChannel,
      this.registeredNote,
      this.skinType,
      this.updatedAt});
}
