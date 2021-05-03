import 'package:blossom_clinic/model/request/create_shipnity_customer_request_model.dart';
import 'package:blossom_clinic/model/request/create_shipnity_order_request_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'shipnity_client.g.dart';

@RestApi(baseUrl: "https://www.shipnity.pro/api/v2/")
abstract class ShipnityClient {
  factory ShipnityClient(Dio dio, {String baseUrl}) = _ShipnityClient;

  @GET("products")
  Future<Response<Map<String, dynamic>>> getProducts(
    @Header("Authorization") String token,
  );

  @GET("customers")
  Future<Response<Map<String, dynamic>>> getShipnityCustomer(
      @Header("Authorization") String token, @Query("terms") String phoneNumber);

  @POST("customers")
  Future<Response<Map<String, dynamic>>> createShipnityCustomer(
      @Header("Authorization") String token, @Body() CreateShipnityCustomerRequestModel requestModel);

  @POST("orders")
  Future<Response<Map<String, dynamic>>> createShipnityOrder(
      @Header("Authorization") String token, @Body() CreateShipnityOrderRequestModel requestModel);

  @GET("orders")
  Future<Response<Map<String, dynamic>>> getOrdersByInvoiceId(
      @Header("Authorization") String token, @Query("terms") String invoiceId);
}
