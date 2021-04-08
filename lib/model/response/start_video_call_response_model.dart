import '../status_model.dart';

class StartVideoCallResponseModel {

  String data;
  StatusModel status;

  StartVideoCallResponseModel({this.data, this.status});

  factory StartVideoCallResponseModel.fromJson(Map<String, dynamic> json) {
    return StartVideoCallResponseModel(
        status: StatusModel.fromJson(json["status"]),
        data: json["data"]);
  }
}