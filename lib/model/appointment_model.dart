import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {

  String date;
  DocumentReference doctorReference;
  DocumentReference orderReference;
  String timeEnd;
  String timeStart;
  DocumentReference userReference;


  AppointmentModel({this.date, this.doctorReference, this.orderReference, this.timeEnd, this.timeStart,
      this.userReference});

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      date: json["date"],
      doctorReference: json["doctorReference"],
      orderReference: json["orderReference"],
      timeEnd: json["timeEnd"],
      timeStart: json["timeStart"],
      userReference: json["userReference"],
    );
  }
}