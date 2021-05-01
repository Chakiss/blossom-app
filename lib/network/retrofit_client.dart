import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'retrofit_client.g.dart';

@RestApi(baseUrl: "https://api.omise.co/")
abstract class RetrofitClient {
  factory RetrofitClient(Dio dio, {String baseUrl}) = _RetrofitClient;

  @FormUrlEncoded()
  @POST("charges")
  Future<Response<Map<String, dynamic>>> charge(
      @Header("Authorization") String omiseSecretKey,
      @Field("amount") int amount,
      @Field("currency") String currency,
      @Field("card") String tokenId,
      @Field("metadata[orderID]") String orderID,
      @Field("return_uri") String returnUri);
}