// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'omise_retrofit_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OmiseRetrofitClient implements OmiseRetrofitClient {
  _OmiseRetrofitClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.omise.co/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<OmiseAddCustomerResponseModel> addCustomer(
      basicToken, email, description) async {
    ArgumentError.checkNotNull(basicToken, 'basicToken');
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(description, 'description');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'email': email, 'description': description};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('customers',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': basicToken},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = OmiseAddCustomerResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<OmiseAddCustomerResponseModel> getCustomer(basicToken, omiseId) async {
    ArgumentError.checkNotNull(basicToken, 'basicToken');
    ArgumentError.checkNotNull(omiseId, 'omiseId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customers/$omiseId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': basicToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = OmiseAddCustomerResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<OmiseAddCardResponseModel> addCard(basicToken, cardNumber,
      cardExpireMonth, cardExpireYear, cardCVV, cardName, address) async {
    ArgumentError.checkNotNull(basicToken, 'basicToken');
    ArgumentError.checkNotNull(cardNumber, 'cardNumber');
    ArgumentError.checkNotNull(cardExpireMonth, 'cardExpireMonth');
    ArgumentError.checkNotNull(cardExpireYear, 'cardExpireYear');
    ArgumentError.checkNotNull(cardCVV, 'cardCVV');
    ArgumentError.checkNotNull(cardName, 'cardName');
    ArgumentError.checkNotNull(address, 'address');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'card[number]': cardNumber,
      'card[expiration_month]': cardExpireMonth,
      'card[expiration_year]': cardExpireYear,
      'card[security_code]': cardCVV,
      'card[name]': cardName,
      'card[address]': address
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'https://vault.omise.co/tokens',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': basicToken},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = OmiseAddCardResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<OmiseAddCustomerResponseModel> addCardToCustomer(
      basicToken, omiseId, email, card, description) async {
    ArgumentError.checkNotNull(basicToken, 'basicToken');
    ArgumentError.checkNotNull(omiseId, 'omiseId');
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(card, 'card');
    ArgumentError.checkNotNull(description, 'description');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'email': email, 'card': card, 'description': description};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'customers/$omiseId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PATCH',
            headers: <String, dynamic>{r'Authorization': basicToken},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = OmiseAddCustomerResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<BuyPackageResponseModel> buyPackage(
      basicToken, description, amount, currency, returnUri, customerId) async {
    ArgumentError.checkNotNull(basicToken, 'basicToken');
    ArgumentError.checkNotNull(description, 'description');
    ArgumentError.checkNotNull(amount, 'amount');
    ArgumentError.checkNotNull(currency, 'currency');
    ArgumentError.checkNotNull(returnUri, 'returnUri');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'description': description,
      'amount': amount,
      'currency': currency,
      'return_uri': returnUri,
      'customer': customerId
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('charges',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': basicToken},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = BuyPackageResponseModel.fromJson(_result.data);
    return value;
  }
}
