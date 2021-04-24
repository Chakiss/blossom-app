import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'retrofit_client.g.dart';

@RestApi(baseUrl: "https://api.omise.co/")
// @RestApi(baseUrl: "https://api.blossom-app.com/blossomapi/")
abstract class RetrofitClient {
  factory RetrofitClient(Dio dio, {String baseUrl}) = _RetrofitClient;

  @FormUrlEncoded()
  @POST("charges")
  Future<Response<Map<String, dynamic>>> charge(
      @Header("Authorization") String omiseSecretKey,
      @Field("amount") int amount,
      @Field("currency") String currency,
      @Field("card") String tokenId,
      @Field("metadata[orderID]") String orderID);
}