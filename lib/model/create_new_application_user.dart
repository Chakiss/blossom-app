class CreateNewApplicationUser {

  String email;
  String phoneNumber;
  String password;
  String passwordConfirm;
  String firstName;
  String lastName;
  String birthDate;
  String skinType;
  String acneTypes;
  String acneCaredNoted;
  String drugAllergyItems;


  CreateNewApplicationUser(this.email, this.phoneNumber, this.password, this.passwordConfirm, this.firstName,
      this.lastName, this.birthDate, this.skinType, this.acneTypes, this.acneCaredNoted, this.drugAllergyItems);

  Map<String, dynamic> toJson() {
    return {"email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "passwordConfirm": passwordConfirm,
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