import 'package:dio/dio.dart';

class StatusModel {

  String resCode;
  String resType;
  String resDesc;

  StatusModel(this.resCode, this.resType, this.resDesc);

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
        json['resCode'],
        json['resType'],
        json['resDesc']
    );
  }

  factory StatusModel.fromObjectError(Object object) {
    if (object.runtimeType == DioError) {
      final response = (object as DioError).response;
      return StatusModel(
          "${response.statusCode}",
          "E",
          response.data["message"] ?? response.statusMessage
      );
    } else {
      return StatusModel(
          "9999",
          "E",
          "Exception"
      );
    }
  }
}