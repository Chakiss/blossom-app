import '../date_reserve_model.dart';

class GetDoctorDateReserveResponseModel {

  int doctorId;
  List<DateReserveModel> dateList;

  GetDoctorDateReserveResponseModel({this.doctorId, this.dateList});

  factory GetDoctorDateReserveResponseModel.fromJson(Map<String, dynamic> json) {
    List<DateReserveModel> list = [];
    json["dateList"].forEach((v) {
      list.add(DateReserveModel.fromJson(v));
    });
    return GetDoctorDateReserveResponseModel(doctorId: json["doctorId"], dateList: list);
  }
}
