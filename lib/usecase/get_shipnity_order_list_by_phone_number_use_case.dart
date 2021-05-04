import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/shipnity_order_model.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:blossom_clinic/utils/error_utils.dart';

class GetShipnityOrderListByPhoneNumberUseCase extends BaseAsyncUseCase<Map<String, dynamic>, List<ShipnityOrderModel>> {

  RemoteRepository _remoteRepository;

  GetShipnityOrderListByPhoneNumberUseCase(this._remoteRepository);

  @override
  Future<Result<List<ShipnityOrderModel>>> execute(Map<String, dynamic> parameter) async {
    try {
      final token = parameter["token"];
      final phoneNumber = parameter["phoneNumber"];
      final response = await _remoteRepository.getShipnityOrderListByPhoneNumber(token, phoneNumber);
      if (response.isSuccess()) {
        final orders = response.data["orders"] as List;
        final data = orders.map((e) => ShipnityOrderModel.fromJson(e)).toList();
        return Success(data);
      } else {
        return Error(ErrorUtils.getErrorMessage(response));
      }
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }

}