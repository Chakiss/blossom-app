import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseModelList<T> {
  List<T> data;

  BaseModelList({this.data});

  factory BaseModelList.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    List<T> data = [];
    if (json["data"] != null) {
      json["data"].forEach((v) {
        data.add(create(v));
      });
    }
    return BaseModelList(
        data: data);
  }
}