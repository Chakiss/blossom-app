class BuyPackageResponseModel {

  String object;
  String location;
  String code;
  String message;

  BuyPackageResponseModel({this.object, this.location, this.code, this.message});

  factory BuyPackageResponseModel.fromJson(Map<String, dynamic> json) {
    return BuyPackageResponseModel(
      object: json["object"],
      location: json["location"],
      code: json["code"],
      message: json["message"],
    );
  }

  Map toJson() {
    return {
      "object": object,
      "location": location,
      "code": code,
      "message": message,
    };
  }
}