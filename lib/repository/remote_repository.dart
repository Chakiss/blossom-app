import 'package:dio/dio.dart';

abstract class RemoteRepository {

  Future<Response<Map<String, dynamic>>> omiseCharge(String omiseSecretKey, int amount, String currency, String tokenId, String orderID, String redirectUrl);

  Future<Response<Map<String, dynamic>>> getProducts(String token);
}
