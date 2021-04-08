import 'package:blossom_clinic/model/response/buy_package_response_model.dart';
import 'package:blossom_clinic/model/response/omise_add_card_response_model.dart';
import 'package:blossom_clinic/model/response/omise_add_customer_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'omise_retrofit_client.g.dart';

@RestApi(baseUrl: "https://api.omise.co/")
abstract class OmiseRetrofitClient {
  factory OmiseRetrofitClient(Dio dio, {String baseUrl}) = _OmiseRetrofitClient;

  @POST("customers")
  @FormUrlEncoded()
  Future<OmiseAddCustomerResponseModel> addCustomer(
      @Header("Authorization") String basicToken,
      @Field("email") String email, @Field("description") String description);

  @GET("customers/{omiseId}")
  Future<OmiseAddCustomerResponseModel> getCustomer(
      @Header("Authorization") String basicToken,
      @Path("omiseId") String omiseId);

  @POST("https://vault.omise.co/tokens")
  @FormUrlEncoded()
  Future<OmiseAddCardResponseModel> addCard(
      @Header("Authorization") String basicToken,
      @Field("card[number]") String cardNumber,
      @Field("card[expiration_month]") String cardExpireMonth,
      @Field("card[expiration_year]") String cardExpireYear,
      @Field("card[security_code]") String cardCVV,
      @Field("card[name]") String cardName,
      @Field("card[address]") String address
      );

  @PATCH("customers/{omiseId}")
  @FormUrlEncoded()
  Future<OmiseAddCustomerResponseModel> addCardToCustomer(
      @Header("Authorization") String basicToken,
      @Path("omiseId") String omiseId,
      @Field("email") String email,
      @Field("card") String card,
      @Field("description") String description);

  @POST("charges")
  @FormUrlEncoded()
  Future<BuyPackageResponseModel> buyPackage(
      @Header("Authorization") String basicToken,
      @Field("description") String description,
      @Field("amount") String amount,
      @Field("currency") String currency,
      @Field("return_uri") String returnUri,
      @Field("customer") String customerId
  );
}
