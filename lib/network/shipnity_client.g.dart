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
  Future<Response<Map<String, dynamic>>> getProducts(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('products',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result;
    return value;
  }
}
