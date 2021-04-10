class GetDoctorMinConsultResponseModel {

  int minute;
  String unit;

  GetDoctorMinConsultResponseModel({this.minute, this.unit});

  factory GetDoctorMinConsultResponseModel.fromJson(Map<String, dynamic> json) {
    return GetDoctorMinConsultResponseModel(
      minute: json["minute"],
      unit: json["unit"]
    );
  }
}