import 'package:blossom_clinic/base/base_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/request/create_new_application_user_request_model.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';

class RegisterUseCase extends BaseUseCase<CreateNewApplicationUserRequestModel, Map<String, dynamic>> {

  RemoteRepository _remoteRepository;

  RegisterUseCase(this._remoteRepository);

  @override
  Future<Result<Map<String, dynamic>>> execute(CreateNewApplicationUserRequestModel parameter) async {
    try {
      final result = await _remoteRepository.register(parameter);
      return Success(Map());
    } catch (e) {
      return Error(e);
    }
  }
}
