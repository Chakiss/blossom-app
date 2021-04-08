import '../status_model.dart';

class EndVideoCallResponseModel {

  StatusModel status;

  EndVideoCallResponseModel({this.status});

  factory EndVideoCallResponseModel.fromJson(Map<String, dynamic> json) {
    return EndVideoCallResponseModel(
        status: StatusModel.fromJson(json["status"])
    );
  }
}