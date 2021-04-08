class GetProfileResponseModel {

  String omiseCustId;
  String omiseSecretKey;
  String cubeId;
  String cubeSecreteKey;
  String cubeName;
  String remainingCallQuota;
  String remainingCallQuotaUnit;
  String email;

  GetProfileResponseModel({this.omiseCustId, this.omiseSecretKey, this.cubeId, this.cubeSecreteKey, this.cubeName,
      this.remainingCallQuota, this.remainingCallQuotaUnit, this.email});

  factory GetProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return GetProfileResponseModel(
        omiseCustId: json["omiseCustId"],
        omiseSecretKey: json["omiseSecretKey"],
        cubeId: json["cubeId"],
        cubeSecreteKey: json["cubeSecreteKey"],
        cubeName: json["cubeName"],
        remainingCallQuota: json["remainingCallQuota"],
        remainingCallQuotaUnit: json["remainingCallQuotaUnit"],
        email: json["email"],
    );
  }

  Map toJson() {
    return {
      "omiseCustId" : omiseCustId,
      "omiseSecretKey" : omiseSecretKey,
      "cubeId" : cubeId,
      "cubeSecreteKey" : cubeSecreteKey,
      "cubeName" : cubeName,
      "remainingCallQuota" : remainingCallQuota,
      "remainingCallQuotaUnit" : remainingCallQuotaUnit,
      "email" : email,
    };
  }
}