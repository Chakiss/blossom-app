import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'shipnity_client.g.dart';

@RestApi(baseUrl: "https://www.shipnity.pro/api/v2/")
abstract class ShipnityClient {
  factory ShipnityClient(Dio dio, {String baseUrl}) = _ShipnityClient;

  @GET("products")
  Future<Response<Map<String, dynamic>>> getProducts(@Header("Authorization") String token,);
}