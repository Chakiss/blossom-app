// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipnity_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ShipnityClient implements ShipnityClient {
  _ShipnityClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://www.shipnity.pro/api/v2/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<Response<Map<String, dynamic>>> getProducts(token, perPage) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(perPage, 'perPage');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'per_page': perPage};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('products',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return _result;
  }

  @override
  Future<Response<Map<String, dynamic>>> getShipnityCustomer(
      token, phoneNumber) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(phoneNumber, 'phoneNumber');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'terms': phoneNumber};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('customers',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return _result;
  }

  @override
  Future<Response<Map<String, dynamic>>> createShipnityCustomer(
      token, requestModel) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(requestModel, 'requestModel');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(requestModel?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('customers',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return _result;
  }

  @override
  Future<Response<Map<String, dynamic>>> createShipnityOrder(
      token, requestModel) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(requestModel, 'requestModel');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(requestModel?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('orders',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return _result;
  }

  @override
  Future<Response<Map<String, dynamic>>> getOrdersByInvoiceId(
      token, invoiceId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(invoiceId, 'invoiceId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'terms': invoiceId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('orders',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return _result;
  }
}
