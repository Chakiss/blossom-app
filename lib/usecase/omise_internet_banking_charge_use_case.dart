import 'dart:convert';

import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:omise_flutter/omise_flutter.dart';

class OmiseInternetBankingChargeUseCase extends BaseAsyncUseCase<Map<String, dynamic>, dynamic> {
  OmiseFlutter _omise;
  RemoteRepository _remoteRepository;

  OmiseInternetBankingChargeUseCase(this._omise, this._remoteRepository);

  @override
  Future<Result> execute(Map<String, dynamic> parameter) async {
    try {
      final String orderID = parameter["orderID"] as String;
      final int amount = parameter["amount"] as int;
      final String sourceType = parameter["sourceType"] as String;
      final result = await _remoteRepository.omiseInternetBankingCharge(
          "Basic " + base64Encode(utf8.encode("skey_test_5n0xzn4kpsvxizlhvox" + ":")),
          // "Basic " + base64Encode(utf8.encode("skey_5nglm3jbzrogirtdtf7" + ":")),
          amount,
          "THB",
          sourceType,
          orderID,
          "https://webhook.site/c546641a-d4eb-4b9d-9b0a-afaf7b28f16b");
      return Success(result.data);
    } catch (e) {
      print(e);
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
