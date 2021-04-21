import 'package:blossom_clinic/model/request/create_new_application_user_request_model.dart';
import 'package:blossom_clinic/model/response/register_response_model.dart';
import 'package:blossom_clinic/network/retrofit_client.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';

class RemoteRepositoryImpl extends RemoteRepository {

  final RetrofitClient retrofitClient;

  RemoteRepositoryImpl({this.retrofitClient});

  @override
  Future<RegisterResponseModel> register(CreateNewApplicationUserRequestModel requestModel) async {
    return await retrofitClient.createNewApplicationUser(requestModel);
  }

}
