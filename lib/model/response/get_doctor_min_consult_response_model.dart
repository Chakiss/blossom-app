class GetDoctorMinConsultResponseModel {

  int quota;
  String unit;
  int packCode;
  int price;

  GetDoctorMinConsultResponseModel({this.quota, this.unit, this.packCode, this.price});

  factory GetDoctorMinConsultResponseModel.fromJson(Map<String, dynamic> json) {
    return GetDoctorMinConsultResponseModel(
        quota: json["quota"], unit: json["unit"], packCode: json["packCode"], price: json["price"]);
  }
}
