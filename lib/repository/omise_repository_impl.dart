import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/response/buy_package_response_model.dart';
import 'package:blossom_clinic/model/response/omise_add_card_response_model.dart';
import 'package:blossom_clinic/model/response/omise_add_customer_response_model.dart';
import 'package:blossom_clinic/model/status_model.dart';
import 'package:blossom_clinic/network/omise_retrofit_client.dart';
import 'package:blossom_clinic/repository/omise_repository.dart';

class OmiseRepositoryImpl extends OmiseRepository {
  final OmiseRetrofitClient omiseRetrofitClient;

  OmiseRepositoryImpl({this.omiseRetrofitClient});

  @override
  Future<Result<OmiseAddCustomerResponseModel>> addCustomer(String basicToken, String email, String description) async {
    try {
      final response = await omiseRetrofitClient.addCustomer(basicToken, email, description);
      if (response.object != "error") {
        return Success(response);
      } else {
        return Error(StatusModel("error", "E", "Exception"));
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  @override
  Future<Result<OmiseAddCustomerResponseModel>> getCustomer(String basicToken, String omiseId) async {
    try {
      final response = await omiseRetrofitClient.getCustomer(basicToken, omiseId);
      if (response.object != "error") {
        return Success(response);
      } else {
        return Error(StatusModel("error", "E", "Exception"));
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  @override
  Future<Result<OmiseAddCardResponseModel>> addCard(String basicToken, String cardNumber, String monthExpire,
      String yearExpire, String cvv, String name, String address) async {
    try {
      final response =
          await omiseRetrofitClient.addCard(basicToken, cardNumber, monthExpire, yearExpire, cvv, name, address);
      if (response.object != "error") {
        return Success(response);
      } else {
        return Error(StatusModel("error", "E", "Exception"));
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  @override
  Future<Result<OmiseAddCustomerResponseModel>> addCardToCustomer(
      String basicToken, String omiseId, String email, String card, String description) async {
    try {
      final response = await omiseRetrofitClient.addCardToCustomer(basicToken, omiseId, email, card, description);
      if (response.object != "error") {
        return Success(response);
      } else {
        return Error(StatusModel("error", "E", "Exception"));
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }

  @override
  Future<Result<BuyPackageResponseModel>> buyPackage(
      String basicToken, String description, String amount, String currency, String returnUri, String customerId) async {
    try {
      final response =
          await omiseRetrofitClient.buyPackage(basicToken, description, amount, currency, returnUri, customerId);
      if (response.object != "error") {
        return Success(response);
      } else {
        return Error(StatusModel("error", "E", response.message));
      }
    } catch (object) {
      return Error(StatusModel.fromObjectError(object));
    }
  }
}
