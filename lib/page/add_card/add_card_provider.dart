import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:flutter/material.dart';

class AddCardProvider extends BaseProvider with ChangeNotifier {

  RemoteRepository _remoteRepository;


  AddCardProvider(this._remoteRepository);

  Future<void> callServiceAddCard(BuildContext context, String name, String city, String zipCode, String number,
      String cvv, String expireMonth, String expireYear) async {

  }
}