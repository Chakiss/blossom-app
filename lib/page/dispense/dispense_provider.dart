import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/usecase/get_product_list_use_case.dart';
import 'package:flutter/material.dart';

class DispenseProvider extends BaseProvider with ChangeNotifier {

  GetProductListUseCase _getProductListUseCase;

  DispenseProvider(this._getProductListUseCase);

  List<dynamic> list;

  Future<void> getProductList(BuildContext context) async {
    final result = await _getProductListUseCase.execute("");
    result.whenWithResult((data) {
      list = data;
      notifyListeners();
    }, (e) {

    });
  }
}