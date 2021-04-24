import 'dart:convert';

import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:omise_flutter/omise_flutter.dart';
import 'package:flutter/foundation.dart';

class OmiseChargeUseCase extends BaseAsyncUseCase<Map<String, dynamic>, dynamic> {

  OmiseFlutter _omise;
  RemoteRepository _remoteRepository;
  OmiseChargeUseCase(this._omise, this._remoteRepository);

  @override
  Future<Result> execute(Map<String, dynamic> parameter) async {
    try {
      final int amount = parameter["amount"] as int;
      final String orderID = parameter["orderID"] as String;
      final token = await _omise.token.create("John Doe", "4242424242424242", "12", "2030", "123");
      final result = await _remoteRepository.omiseCharge(
      "Basic " + base64Encode(utf8.encode("skey_test_5n0xzn4kpsvxizlhvox" + ":")),
          amount,
          "THB",
          token.id,
          orderID);
      debugPrint(json.encode(result.data));
      return Success("success");
    } catch (e) {
      print(e);
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}