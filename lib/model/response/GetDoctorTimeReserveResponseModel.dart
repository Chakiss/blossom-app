import 'package:blossom_clinic/model/doctor_time_model.dart';

class GetDoctorTimeReserveResponseModel {

  String date;
  List<DoctorTimeModel> timeList;


  GetDoctorTimeReserveResponseModel({this.date, this.timeList});

  factory GetDoctorTimeReserveResponseModel.fromJson(Map<String, dynamic> json) {
    List<DoctorTimeModel> list = [];
    json["timeList"].forEach((value) {
      list.add(DoctorTimeModel.fromJson(value));
    });
    return GetDoctorTimeReserveResponseModel(
      date: json["date"],
      timeList: list
    );
  }
}