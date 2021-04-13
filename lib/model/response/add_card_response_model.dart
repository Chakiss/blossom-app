import 'package:blossom_clinic/model/status_model.dart';

class AddCardResponseModel {

  StatusModel status;

  AddCardResponseModel({this.status});

  factory AddCardResponseModel.fromJson(Map<String, dynamic> json) {
    return AddCardResponseModel(
        status: json["status"]
    );
  }
}