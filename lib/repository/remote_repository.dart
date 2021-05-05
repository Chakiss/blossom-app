import 'package:blossom_clinic/model/request/create_shipnity_customer_request_model.dart';
import 'package:blossom_clinic/model/request/create_shipnity_order_request_model.dart';
import 'package:dio/dio.dart';

abstract class RemoteRepository {

  Future<Response<Map<String, dynamic>>> omiseCharge(String omiseSecretKey, int amount, String currency, String tokenId, String orderID, String redirectUrl);

  Future<Response<Map<String, dynamic>>> omiseInternetBankingCharge(String omiseSecretKey, int amount, String currency,String sourceType, String orderID, String redirectUrl);

  Future<Response<Map<String, dynamic>>> getProducts(String token);

  Future<Response<Map<String, dynamic>>> getShipnityCustomer(String token, String phoneNumber);

  Future<Response<Map<String, dynamic>>> createShipnityCustomer(String token, CreateShipnityCustomerRequestModel requestModel);

  Future<Response<Map<String, dynamic>>> createShipnityOrder(String token, CreateShipnityOrderRequestModel requestModel);

  Future<Response<Map<String, dynamic>>> getShipnityOrderByInvoiceId(String token, String invoiceId);

  Future<Response<Map<String, dynamic>>> getShipnityOrderListByPhoneNumber(String token, String phoneNumber);
}
