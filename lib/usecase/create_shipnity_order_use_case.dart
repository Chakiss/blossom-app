import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/product_model.dart';
import 'package:blossom_clinic/model/purchases_attributes_model.dart';
import 'package:blossom_clinic/model/request/create_shipnity_order_request_model.dart';
import 'package:blossom_clinic/model/shipnity_customer_model.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:blossom_clinic/utils/user_data.dart';

class CreateShipnityOrderUseCase extends BaseAsyncUseCase<Map<String, dynamic>, Map<String, dynamic>> {
  UserData _userData;
  RemoteRepository _remoteRepository;

  CreateShipnityOrderUseCase(this._userData, this._remoteRepository);

  @override
  Future<Result<Map<String, dynamic>>> execute(Map<String, dynamic> parameter) async {
    try {
      final token = parameter["token"] as String;
      final shipnityCustomerModel = parameter["shipnityCustomerModel"] as ShipnityCustomerModel;
      final productSelected = Map<ProductModel, int>.from(parameter["productSelected"]);
      List<PurchasesAttributesModel> purchasesAttributes = [];
      productSelected
        ..forEach((key, value) {
          purchasesAttributes.add(PurchasesAttributesModel(
              id: null, subproduct_id: key.subproducts?.first?.id, quantity: value, price: key.object_price.round(), discount: 0));
        });
      final orderModel = CreateShipnityOrder(
          customer: shipnityCustomerModel.id,
          name: shipnityCustomerModel.name,
          address: "",
          tel: shipnityCustomerModel.tel,
          contact_method: "blossom_app",
          email: shipnityCustomerModel.email,
          annotation: _userData.doctorInfoModel.doctorId,
          tag: "app",
          shipping_type: "EMS",
          shipping_fee: 0,
          preorder: false,
          taxable: false,
          order_discount: 0,
          purchases_attributes: purchasesAttributes);
      final requestModel = CreateShipnityOrderRequestModel(order: orderModel);
      final response = await _remoteRepository.createShipnityOrder(token, requestModel);
      if (response.isSuccess()) {
        return Success({});
      } else {
        return Error(ErrorUtils.getErrorMessage(response));
      }
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
