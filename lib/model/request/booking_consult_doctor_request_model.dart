class BookingConsultDoctorRequestModel {
  int packCode;
  int doctorId;
  String startDate;
  String endDate;

  BookingConsultDoctorRequestModel(this.packCode, this.doctorId, this.startDate, this.endDate);

  Map<String, dynamic> toJson() {
    return {"packCode": packCode, "doctorId": doctorId, "startDate": startDate, "endDate": endDate};
  }
}
