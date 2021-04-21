import '../create_new_application_user.dart';

class CreateNewApplicationUserRequestModel {

  CreateNewApplicationUser data;

  CreateNewApplicationUserRequestModel(this.data);

  Map<String, dynamic> toJson() {
    return {
      "data" : data.toJson()
    };
  }
}