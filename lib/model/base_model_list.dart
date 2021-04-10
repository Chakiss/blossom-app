import 'package:blossom_clinic/model/status_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseModelList<T> {
  StatusModel status;
  List<T> data;

  BaseModelList({this.status, this.data});

  factory BaseModelList.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    List<T> data = [];
    json["data"].forEach((v) {
      data.add(create(v));
    });
    return BaseModelList(
        status: StatusModel.fromJson(json["status"]),
        data: data);
  }
}