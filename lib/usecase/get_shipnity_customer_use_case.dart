import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/shipnity_customer_model.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:blossom_clinic/utils/error_utils.dart';

class GetShipnityCustomerUseCase extends BaseAsyncUseCase<Map<String, dynamic>, ShipnityCustomerModel> {
  RemoteRepository _remoteRepository;

  GetShipnityCustomerUseCase(this._remoteRepository);

  @override
  Future<Result<ShipnityCustomerModel>> execute(Map<String, dynamic> parameter) async {
    try {
      final String token = parameter["token"];
      final String phoneNumber = parameter["phoneNumber"];
      final response = await _remoteRepository.getShipnityCustomer(token, phoneNumber);
      if (response.isSuccess()) {
        if ((response.data["customers"] as List).isEmpty ?? true) {
          return Success(null);
        } else {
          return Success(ShipnityCustomerModel.fromJson(Map<String, dynamic>.from((response.data["customers"] as List).first)));
        }
      } else {
        return Error(ErrorUtils.getErrorMessage(response));
      }
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
