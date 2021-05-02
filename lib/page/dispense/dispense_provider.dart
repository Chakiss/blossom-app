import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/product_model.dart';
import 'package:blossom_clinic/model/shipnity_customer_model.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/network/service_properties.dart';
import 'package:blossom_clinic/usecase/create_shipnity_order_use_case.dart';
import 'package:blossom_clinic/usecase/get_product_list_use_case.dart';
import 'package:flutter/material.dart';

class DispenseProvider extends BaseProvider with ChangeNotifier {
  GetProductListUseCase _getProductListUseCase;
  CreateShipnityOrderUseCase _createShipnityOrderUseCase;

  DispenseProvider(this._getProductListUseCase, this._createShipnityOrderUseCase);

  List<dynamic> list;
  Map<ProductModel, int> productSelected = {};

  Future<void> getProductList(BuildContext context) async {
    final result = await _getProductListUseCase.execute(ServiceProperties.SHIPNITY_TOKEN);
    result.whenWithResult((data) {
      list = data;
      notifyListeners();
    }, (e) {});
  }

  void addProductToOrder(ProductModel productModel, int amount) {
    if (amount == 0) {
      if (productSelected.containsKey(productModel)) {
        productSelected.remove(productModel);
      }
    } else {
      productSelected[productModel] = amount;
    }
  }

  Future<void> callServiceCreateOrder(
      BuildContext context, UserProfileModel userProfileModel, ShipnityCustomerModel shipnityCustomerModel) async {
    final result = await _createShipnityOrderUseCase.execute({
      "token": ServiceProperties.SHIPNITY_TOKEN,
      "shipnityCustomerModel": shipnityCustomerModel,
      "productSelected": productSelected
    });
    result.whenWithResult((data) {

    }, (map) {
      errorHandle.proceed(context, map);
    });
  }
}
