import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/customer_order_model.dart';
import 'package:blossom_clinic/usecase/get_customer_order_use_case.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:flutter/material.dart';

class HistoryProvider extends BaseProvider with ChangeNotifier {

  GetCustomerOrderUseCase _getCustomerOrderUseCase;
  UserData _userData;
  List<CustomerOrderModel> customerOrderList;

  HistoryProvider(this._getCustomerOrderUseCase, this._userData);

  Future<void> getCustomerOrder(BuildContext context) async {
    final result = await _getCustomerOrderUseCase.execute(_userData.userProfileModel.userUID);
    result.whenWithResult((data) {
      customerOrderList = data;
      notifyListeners();
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }
}