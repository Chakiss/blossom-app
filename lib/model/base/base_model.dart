import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseModel<T> {
  T data;

  BaseModel({this.data});

  Map<String, dynamic> toJson() {
    return {"data": data};
  }

  factory BaseModel.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return BaseModel(data: json["data"] != null ? create(json["data"]) : null);
  }
}
