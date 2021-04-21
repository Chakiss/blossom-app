import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/create_new_application_user.dart';
import 'package:blossom_clinic/model/request/create_new_application_user_request_model.dart';
import 'package:blossom_clinic/usecase/register_use_case.dart';
import 'package:flutter/material.dart';

class RegisterSecondProvider extends BaseProvider with ChangeNotifier {
  RegisterUseCase _registerUseCase;

  RegisterSecondProvider(this._registerUseCase);

  Future<void> callServiceRegister(BuildContext context, Map<String, String> profileData, String skinType,
      String acneTypes, String acneTreatText, String drugAllergyText) async {
    final data = CreateNewApplicationUser(
        profileData["email"],
        profileData["phoneNumber"],
        profileData["password"],
        profileData["confirmPassword"],
        profileData["name"],
        profileData["lastName"],
        profileData["dateOfBirth"],
        skinType,
        acneTypes,
        acneTreatText,
        drugAllergyText);
    print(data.toJson());
    final requestModel = CreateNewApplicationUserRequestModel(data);
    final result = await _registerUseCase.execute(requestModel);
  }
}
