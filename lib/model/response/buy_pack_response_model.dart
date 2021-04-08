class BuyPackResponseModel {
  String omiseRef;
  String omiseChargeAuthUrl;

  BuyPackResponseModel({this.omiseRef, this.omiseChargeAuthUrl});

  factory BuyPackResponseModel.fromJson(Map<String, dynamic> json) {
    return BuyPackResponseModel(
      omiseRef: json["omiseRef"],
      omiseChargeAuthUrl: json["omiseChargeAuthUrl"],
    );
  }

  Map toJson() {
    return {
      "omiseRef": omiseRef,
      "omiseChargeAuthUrl": omiseChargeAuthUrl,
    };
  }
}
