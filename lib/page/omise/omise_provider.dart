import 'package:blossom_clinic/base/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:omise_flutter/omise_flutter.dart';

class OmiseProvider extends BaseProvider with ChangeNotifier {

  OmiseFlutter omise = OmiseFlutter("pkey_test_5mmq1gnwqw4n78r3sil");

  Future<void> initOmise() async {
    final token = await omise.token.create("John Doe", "4242424242424242", "12", "2030", "123");
    final source = await omise.source.create(10000, "thb", "internet_banking_bay");
    print(source.id);
    // final capability = await omise.capability.retrieve();
    // print(capability.paymentMethods);
  }
}