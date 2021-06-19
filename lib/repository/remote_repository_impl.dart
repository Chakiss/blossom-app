import 'package:blossom_clinic/model/request/create_shipnity_customer_request_model.dart';
import 'package:blossom_clinic/model/request/create_shipnity_order_request_model.dart';
import 'package:blossom_clinic/network/retrofit_client.dart';
import 'package:blossom_clinic/network/shipnity_client.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:dio/dio.dart';

class RemoteRepositoryImpl extends RemoteRepository {
  final RetrofitClient retrofitClient;
  final ShipnityClient shipnityClient;

  RemoteRepositoryImpl({this.retrofitClient, this.shipnityClient});

  @override
  Future<Response<Map<String, dynamic>>> omiseCharge(
      String omiseSecretKey, int amount, String currency, String tokenId, String orderID, String redirectUrl) async {
    return await retrofitClient.charge(omiseSecretKey, amount, currency, tokenId, orderID, redirectUrl);
  }

  @override
  Future<Response<Map<String, dynamic>>> omiseInternetBankingCharge(
      String omiseSecretKey, int amount, String currency, String sourceType, String orderID, String redirectUrl) async {
    return await retrofitClient.internetBankingCharge(
        omiseSecretKey, amount, currency, sourceType, orderID, redirectUrl);
  }

  @override
  Future<Response<Map<String, dynamic>>> getProducts(String token, String perPage) async {
    return await shipnityClient.getProducts(token, perPage);
  }

  @override
  Future<Response<Map<String, dynamic>>> getShipnityCustomer(String token, String phoneNumber) async {
    return await shipnityClient.getShipnityCustomer(token, phoneNumber);
  }

  @override
  Future<Response<Map<String, dynamic>>> createShipnityCustomer(
      String token, CreateShipnityCustomerRequestModel requestModel) async {
    return await shipnityClient.createShipnityCustomer(token, requestModel);
  }

  @override
  Future<Response<Map<String, dynamic>>> createShipnityOrder(
      String token, CreateShipnityOrderRequestModel requestModel) async {
    return await shipnityClient.createShipnityOrder(token, requestModel);
  }

  @override
  Future<Response<Map<String, dynamic>>> getShipnityOrderByInvoiceId(String token, String invoiceId) async {
    return await shipnityClient.getOrdersByInvoiceId(token, invoiceId);
  }

  @override
  Future<Response<Map<String, dynamic>>> getShipnityOrderListByPhoneNumber(String token, String phoneNumber) async {
    return await shipnityClient.getOrdersByInvoiceId(token, phoneNumber);
  }
}
