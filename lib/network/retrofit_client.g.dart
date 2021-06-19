// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RetrofitClient implements RetrofitClient {
  _RetrofitClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.omise.co/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<Response<Map<String, dynamic>>> charge(
      omiseSecretKey, amount, currency, tokenId, orderID, returnUri) async {
    ArgumentError.checkNotNull(omiseSecretKey, 'omiseSecretKey');
    ArgumentError.checkNotNull(amount, 'amount');
    ArgumentError.checkNotNull(currency, 'currency');
    ArgumentError.checkNotNull(tokenId, 'tokenId');
    ArgumentError.checkNotNull(orderID, 'orderID');
    ArgumentError.checkNotNull(returnUri, 'returnUri');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'amount': amount,
      'currency': currency,
      'card': tokenId,
      'metadata[orderID]': orderID,
      'return_uri': returnUri
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('charges',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': omiseSecretKey},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    return _result;
  }

  @override
  Future<Response<Map<String, dynamic>>> internetBankingCharge(
      omiseSecretKey, amount, currency, sourceType, orderID, returnUri) async {
    ArgumentError.checkNotNull(omiseSecretKey, 'omiseSecretKey');
    ArgumentError.checkNotNull(amount, 'amount');
    ArgumentError.checkNotNull(currency, 'currency');
    ArgumentError.checkNotNull(sourceType, 'sourceType');
    ArgumentError.checkNotNull(orderID, 'orderID');
    ArgumentError.checkNotNull(returnUri, 'returnUri');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'amount': amount,
      'currency': currency,
      'source[type]': sourceType,
      'metadata[orderID]': orderID,
      'return_uri': returnUri
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('charges',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': omiseSecretKey},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    return _result;
  }
}
