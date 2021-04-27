import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProfileFacebookLoginModel {
  String acneCaredNoted;
  bool acneIsCared;
  List<int> acneTypes;
  Timestamp birthDate;
  Timestamp createdAt;
  List<String> drugAllergyItems;
  bool drugAllergyStatus;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  String registeredChannel;
  String registeredNote;
  int skinType;
  Timestamp updatedAt;

  UpdateProfileFacebookLoginModel(
      {this.acneCaredNoted,
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

  Map<String, dynamic> toJson() {
    return {
      "acneCaredNoted": acneCaredNoted,
      "acneIsCared": acneIsCared,
      "acneTypes": acneTypes,
      "birthDate": birthDate,
      "createdAt": createdAt,
      "drugAllergyItems": drugAllergyItems,
      "drugAllergyStatus": drugAllergyStatus,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "registeredChannel": registeredChannel,
      "registeredNote": registeredNote,
      "skinType": skinType,
      "updatedAt": updatedAt,
    };
  }
}
