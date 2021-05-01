import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/request/create_shipnity_customer_request_model.dart';
import 'package:blossom_clinic/model/shipnity_customer_model.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:blossom_clinic/utils/error_utils.dart';

class CreateShipnityCustomerUseCase extends BaseAsyncUseCase<Map<String, dynamic>, ShipnityCustomerModel> {

  RemoteRepository _remoteRepository;

  CreateShipnityCustomerUseCase(this._remoteRepository);

  @override
  Future<Result<ShipnityCustomerModel>> execute(Map<String, dynamic> parameter) async {
    try {
      final String token = parameter["token"];
      final CreateShipnityCustomerRequestModel requestModel = parameter["requestModel"];
      final response = await _remoteRepository.createShipnityCustomer(token, requestModel);
      if (response.isSuccess()) {
        return Success(ShipnityCustomerModel.fromJson(response.data));
      } else {
        return Error(ErrorUtils.getErrorMessage(response));
      }
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }

}