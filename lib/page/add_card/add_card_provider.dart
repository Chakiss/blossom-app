import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/request/add_card_request_model.dart';
import 'package:blossom_clinic/model/user_model.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:flutter/material.dart';

class AddCardProvider extends BaseProvider with ChangeNotifier {

  RemoteRepository _remoteRepository;
  UserModel _userModel;


  AddCardProvider(this._remoteRepository, this._userModel);

  Future<void> callServiceAddCard(BuildContext context, String name, String city, String zipCode, String number,
      String cvv, String expireMonth, String expireYear) async {
    final requestModel = AddCardRequestModel(
        name: name ?? "",
        city: city ?? "",
        zipCode: zipCode ?? "",
        number: number ?? "",
        securityCode: cvv,
        expireMonth: int.parse(expireMonth ?? "0"),
        expireYear: int.parse("20" + expireYear ?? "0"));
    final result = await _remoteRepository.addCard(_userModel.getBearerToken(), requestModel);
    result.whenWithResult((data) {
      showToast("เพิ่มการ์ดสำเร็จ กรุณาทำรายการอีกครั้ง");
      Navigator.pop(context);
    }, (statusModel) {
      errorHandle.proceed(context, statusModel);
    });
  }
}