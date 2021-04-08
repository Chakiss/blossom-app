import 'package:blossom_clinic/model/status_model.dart';

class BaseModel<T> {
  StatusModel status;
  T data;

  BaseModel({this.status, this.data});

  factory BaseModel.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return BaseModel(
        status: StatusModel.fromJson(json["status"]),
        data: create(json["data"]));
  }
}