import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/usecase/omise_charge_use_case.dart';
import 'package:flutter/material.dart';

class OmiseProvider extends BaseProvider with ChangeNotifier {

  OmiseChargeUseCase _chargeOmiseUseCase;

  OmiseProvider(this._chargeOmiseUseCase);

  Future<void> initOmise(String orderId) async {
    final result = await _chargeOmiseUseCase.execute({
      "amount" : 2000,
      "orderID" : orderId
    });
  }
}