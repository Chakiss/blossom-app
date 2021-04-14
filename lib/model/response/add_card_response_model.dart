import 'package:blossom_clinic/model/status_model.dart';

class AddCardResponseModel {

  dynamic data;
  StatusModel status;

  AddCardResponseModel({this.data, this.status});

  factory AddCardResponseModel.fromJson(Map<String, dynamic> json) {
    return AddCardResponseModel(
        data: json["data"] ?? null,
        status: StatusModel.fromJson(json["status"])
    );
  }
}