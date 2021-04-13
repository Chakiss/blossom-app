class AddCardRequestModel {

  String name;
  String city;
  String zipCode;
  String number;
  String securityCode;
  int expireMonth;
  int expireYear;

  AddCardRequestModel({this.name, this.city, this.zipCode, this.number, this.securityCode, this.expireMonth,
      this.expireYear});

  Map<String, dynamic> toJson() {
    return {
      "name" : name,
      "city" : city,
      "zipCode" : zipCode,
      "number" : number,
      "securityCode" : securityCode,
      "expireMonth" : expireMonth,
      "expireYear" : expireYear,
    };
  }
}