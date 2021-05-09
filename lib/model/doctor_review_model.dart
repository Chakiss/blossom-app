import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorReviewModel {

  String reviewId;
  DocumentReference appointmentReference;
  String comment;
  Timestamp createdAt;
  DocumentReference doctorReference;
  DocumentReference patientReference;
  int score;
  String type;
  Timestamp updatedAt;

  DoctorReviewModel({this.reviewId, this.appointmentReference, this.comment, this.createdAt, this.doctorReference,
      this.patientReference, this.score, this.type, this.updatedAt});

  factory DoctorReviewModel.fromJson(String id, Map<String, dynamic> json) {
    return DoctorReviewModel(
      reviewId: id,
      appointmentReference: json["appointmentReference"],
      comment: json["comment"],
      createdAt: json["createdAt"],
      doctorReference: json["doctorReference"],
      patientReference: json["patientReference"],
      score: json["score"],
      type: json["type"],
      updatedAt: json["updatedAt"],
    );
  }
}