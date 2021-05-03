import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/product_model.dart';
import 'package:blossom_clinic/model/shipnity_customer_model.dart';
import 'package:blossom_clinic/network/service_properties.dart';
import 'package:blossom_clinic/usecase/create_shipnity_order_use_case.dart';
import 'package:blossom_clinic/usecase/get_product_list_use_case.dart';
import 'package:blossom_clinic/usecase/update_shipnity_reference_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:flutter/material.dart';

class DispenseProvider extends BaseProvider with ChangeNotifier {
  GetProductListUseCase _getProductListUseCase;
  CreateShipnityOrderUseCase _createShipnityOrderUseCase;
  ShipnityCustomerModel _shipnityCustomerModel;
  UpdateShipnityReferenceUseCase _updateShipnityReferenceUseCase;
  String _appointmentId;

  DispenseProvider(this._getProductListUseCase, this._createShipnityOrderUseCase, this._updateShipnityReferenceUseCase,
      this._shipnityCustomerModel, this._appointmentId);

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

  Future<void> callServiceCreateOrder(BuildContext context) async {
    showProgressDialog(context);
    final result = await _createShipnityOrderUseCase.execute({
      "token": ServiceProperties.SHIPNITY_TOKEN,
      "shipnityCustomerModel": _shipnityCustomerModel,
      "productSelected": productSelected
    });
    result.whenWithResult((data) {
      callUpdateShipnityReference(context, data["order"]["invoice_number"] as String);
    }, (map) {
      Navigator.pop(context, RouteManager.routeDoctorMain(initIndex: 1));
      errorHandle.proceed(context, map);
    });
  }

  Future<void> callUpdateShipnityReference(BuildContext context, String invoiceId) async {
    final result = await _updateShipnityReferenceUseCase
        .execute({"appointmentID": _appointmentId, "shipnityReferenceID": invoiceId});
    Navigator.pop(context, RouteManager.routeDoctorMain(initIndex: 1));
    result.whenWithResult((data) {
      showToast("บันทึกรายการสั่งยาเรียบร้อยแล้ว");
      Navigator.pushAndRemoveUntil(context, RouteManager.routeDoctorMain(initIndex: 1), (route) => false);
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }
}
