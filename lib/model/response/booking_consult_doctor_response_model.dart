class BookingConsultDoctorResponseModel {

  String total;
  String omiseRef;
  String omiseChargeAuthUrl;
  int quota;

  BookingConsultDoctorResponseModel({this.total, this.omiseRef, this.omiseChargeAuthUrl, this.quota});

  factory BookingConsultDoctorResponseModel.fromJson(Map<String, dynamic> json) {
    return BookingConsultDoctorResponseModel(
      total: json["total"],
      omiseRef: json["omiseRef"],
      omiseChargeAuthUrl: json["omiseChargeAuthUrl"],
      quota: json["quota"],
    );
  }
}