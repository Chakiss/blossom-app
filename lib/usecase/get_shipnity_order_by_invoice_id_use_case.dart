import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/shipnity_order_model.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:blossom_clinic/utils/error_utils.dart';

class GetShipnityOrderByInvoiceIdUseCase extends BaseAsyncUseCase<Map<String, dynamic>, ShipnityOrderModel> {

  RemoteRepository _remoteRepository;

  GetShipnityOrderByInvoiceIdUseCase(this._remoteRepository);

  @override
  Future<Result<ShipnityOrderModel>> execute(Map<String, dynamic> parameter) async {
    try {
      final token = parameter["token"];
      final invoiceId = parameter["invoiceId"];
      final response = await _remoteRepository.getShipnityOrderByInvoiceId(token, invoiceId);
      if (response.isSuccess()) {
        return Success(ShipnityOrderModel.fromJson(response.data));
      } else {
        return Error(ErrorUtils.getErrorMessage(response));
      }
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }

}