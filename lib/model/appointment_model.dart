import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  String date;
  DocumentReference doctorReference;
  Form form;
  DocumentReference orderReference;
  String timeEnd;
  String timeStart;
  DocumentReference userReference;

  AppointmentModel(
      {this.date,
      this.doctorReference,
      this.form,
      this.orderReference,
      this.timeEnd,
      this.timeStart,
      this.userReference});

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      date: json["date"],
      doctorReference: json["doctorReference"],
      form: Form.fromJson(json["form"]),
      orderReference: json["orderReference"],
      timeEnd: json["timeEnd"],
      timeStart: json["timeStart"],
      userReference: json["userReference"],
    );
  }
}

class Form {
  Post post;
  Pre pre;

  Form({this.post, this.pre});

  factory Form.fromJson(Map<String, dynamic> json) {
    return Form(post: Post.fromJson(json["post"]), pre: Pre.fromJson(json["pre"]));
  }
}

class Post {
  String carePlan;
  String careRecommendation;
  Timestamp createdAt;
  String diagnoses;
  bool isCompleted;
  String nextAppointment;
  String productsRecommendation;
  String skinOverview;
  String skinType;
  Timestamp updatedAt;

  Post(
      {this.carePlan,
      this.careRecommendation,
      this.createdAt,
      this.diagnoses,
      this.isCompleted,
      this.nextAppointment,
      this.productsRecommendation,
      this.skinOverview,
      this.skinType,
      this.updatedAt});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      carePlan: json["carePlan"],
      careRecommendation: json["careRecommendation"],
      createdAt: json["createdAt"],
      diagnoses: json["diagnoses"],
      isCompleted: json["isCompleted"],
      nextAppointment: json["nextAppointment"],
      productsRecommendation: json["productsRecommendation"],
      skinOverview: json["skinOverview"],
      skinType: json["skinType"],
      updatedAt: json["updatedAt"],
    );
  }
}

class Pre {
  String acneCared;
  int acnePeriod;
  String changeProduct;
  Timestamp createdAt;
  bool frequenceSweet;
  List<DocumentReference> images;
  bool isCompleted;
  bool isStressed;
  bool normalMenstruation;
  bool sleepDeprivation;
  Timestamp updatedAt;

  Pre(
      {this.acneCared,
      this.acnePeriod,
      this.changeProduct,
      this.createdAt,
      this.frequenceSweet,
      this.images,
      this.isCompleted,
      this.isStressed,
      this.normalMenstruation,
      this.sleepDeprivation,
      this.updatedAt});

  factory Pre.fromJson(Map<String, dynamic> json) {
    return Pre(
      acneCared: json["acneCared"],
      acnePeriod: json["acnePeriod"],
      changeProduct: json["changeProduct"],
      createdAt: json["createdAt"],
      frequenceSweet: json["frequenceSweet"],
      images: (json["images"] as List).map((e) => e as DocumentReference).toList(),
      isCompleted: json["isCompleted"],
      isStressed: json["isStressed"],
      normalMenstruation: json["normalMenstruation"],
      sleepDeprivation: json["sleepDeprivation"],
      updatedAt: json["updatedAt"],
    );
  }
}
