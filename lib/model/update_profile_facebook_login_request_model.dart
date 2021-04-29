class UpdateProfileFacebookLoginRequestModel {
  String id;
  String email;
  String phoneNumber;
  String firstName;
  String lastName;
  String birthDate;
  String skinType;
  String acneTypes;
  String acneCaredNoted;
  String drugAllergyItems;

  UpdateProfileFacebookLoginRequestModel(this.id, this.email, this.phoneNumber, this.firstName, this.lastName,
      this.birthDate, this.skinType, this.acneTypes, this.acneCaredNoted, this.drugAllergyItems);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "phoneNumber": phoneNumber,
      "firstName": firstName,
      "lastName": lastName,
      "birthDate": birthDate,
      "skinType": skinType,
      "acneTypes": acneTypes,
      "acneCaredNoted": acneCaredNoted,
      "drugAllergyItems": drugAllergyItems,
    };
  }
}
