import 'package:blossom_clinic/model/request/create_new_application_user_request_model.dart';
import 'package:blossom_clinic/model/response/register_response_model.dart';

abstract class RemoteRepository {

  Future<RegisterResponseModel> register(CreateNewApplicationUserRequestModel requestModel);
}
