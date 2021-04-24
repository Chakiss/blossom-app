import 'package:blossom_clinic/network/retrofit_client.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:dio/dio.dart';

class RemoteRepositoryImpl extends RemoteRepository {
  final RetrofitClient retrofitClient;

  RemoteRepositoryImpl({this.retrofitClient});

  @override
  Future<Response<Map<String, dynamic>>> omiseCharge(String omiseSecretKey, int amount, String currency, String tokenId, String orderID) async {
    return await retrofitClient.charge(omiseSecretKey, amount, currency, tokenId, orderID);
  }
}
