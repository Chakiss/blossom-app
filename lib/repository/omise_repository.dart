import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/response/buy_package_response_model.dart';
import 'package:blossom_clinic/model/response/omise_add_card_response_model.dart';
import 'package:blossom_clinic/model/response/omise_add_customer_response_model.dart';

abstract class OmiseRepository {
  Future<Result<OmiseAddCustomerResponseModel>> addCustomer(String basicToken, String email, String description);

  Future<Result<OmiseAddCustomerResponseModel>> getCustomer(String basicToken, String omiseId);

  Future<Result<OmiseAddCardResponseModel>> addCard(String basicToken, String cardNumber, String monthExpire,
      String yearExpire, String cvv, String name, String address);

  Future<Result<OmiseAddCustomerResponseModel>> addCardToCustomer(
      String basicToken, String omiseId, String email, String card, String description);

  Future<Result<BuyPackageResponseModel>> buyPackage(
      String basicToken,
      String description,
      String amount,
      String currency,
      String returnUri,
      String customerId
      );
}
