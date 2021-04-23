import 'package:blossom_clinic/model/base/request_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseRequestModel<T extends RequestModel> {
  T data;

  BaseRequestModel(this.data);

  Map<String, dynamic> toJson() {
    return {"data": data.toJson()};
  }
}
