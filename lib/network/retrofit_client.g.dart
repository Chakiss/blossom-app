// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RetrofitClient implements RetrofitClient {
  _RetrofitClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://apitest.blossom-app.com/blossomapi/';
    // baseUrl ??= 'https://api.blossom-app.com/blossomapi/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<BaseModel<SignInFacebookResponseModel>> signInWithFacebook(requestModel) async {
    ArgumentError.checkNotNull(requestModel, 'requestModel');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = requestModel;
    final _result = await _dio.request<Map<String, dynamic>>('auth/v1.0.0/signInWithFacebook',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{"Content-Type": "application/json; charset=UTF-8"},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseModel<SignInFacebookResponseModel>.fromJson(
        _result.data, (json) => SignInFacebookResponseModel.fromJson(json));
    return value;
  }

  @override
  Future<BaseModelList<PackageResponseModel>> getPackage(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('package/v1.0.0/videoCon?packCode=1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{'Authorization': token}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value =
        BaseModelList<PackageResponseModel>.fromJson(_result.data, (json) => PackageResponseModel.fromJson(json));
    return value;
  }

  @override
  Future<BaseModel<GetProfileResponseModel>> getProfile(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('user/v1.0.0/profile',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{'Authorization': token}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value =
        BaseModel<GetProfileResponseModel>.fromJson(_result.data, (json) => GetProfileResponseModel.fromJson(json));
    return value;
  }

  @override
  Future<BaseModel<BuyPackResponseModel>> buyPackage(token, packCode) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(packCode, 'packCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'packCode': packCode};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('package/v2.0.0/videoCon',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST', headers: <String, dynamic>{'Authorization': token}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value = BaseModel<BuyPackResponseModel>.fromJson(_result.data, (json) => BuyPackResponseModel.fromJson(json));
    return value;
  }

  @override
  Future<BaseModel<GetSourceDestinationResponseModel>> getSourceDestination(token, sourceCubeId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(sourceCubeId, 'sourceCubeId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'sourceCubeId': sourceCubeId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('videoCon/v1.0.0/getSourceDesc',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{'Authorization': token}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value = BaseModel<GetSourceDestinationResponseModel>.fromJson(
        _result.data, (json) => GetSourceDestinationResponseModel.fromJson(json));
    return value;
  }

  @override
  Future<StartVideoCallResponseModel> startVideoCall(token, requestModel) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(requestModel, 'requestModel');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(requestModel?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('videoCon/v1.0.0/startVideoCon',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST', headers: <String, dynamic>{r'Authorization': token}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value = StartVideoCallResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<EndVideoCallResponseModel> endVideoCall(token, requestModel) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(requestModel, 'requestModel');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(requestModel?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('videoCon/v1.0.0/endVideoCon',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST', headers: <String, dynamic>{r'Authorization': token}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value = EndVideoCallResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<BaseModelList<DoctorInfo>> getDoctorList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('doctorInfo/v1.0.0/getDoctorsInfo',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: <String, dynamic>{}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value = BaseModelList<DoctorInfo>.fromJson(_result.data, (json) => DoctorInfo.fromJson(json));
    return value;
  }

  @override
  Future<BaseModel<GetDoctorDateReserveResponseModel>> getDoctorDateReserve(doctorId) async {
    ArgumentError.checkNotNull(doctorId, 'doctorId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'doctorId': doctorId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('doctorInfo/v1.0.0/getDoctorDateReserve',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: <String, dynamic>{}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value = BaseModel<GetDoctorDateReserveResponseModel>.fromJson(
        _result.data, (json) => GetDoctorDateReserveResponseModel.fromJson(json));
    return value;
  }

  @override
  Future<BaseModelList<GetDoctorMinConsultResponseModel>> getDoctorMinConsult() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('doctorInfo/v1.0.0/getDoctorMinConsult',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: <String, dynamic>{}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value = BaseModelList<GetDoctorMinConsultResponseModel>.fromJson(
        _result.data, (json) => GetDoctorMinConsultResponseModel.fromJson(json));
    return value;
  }

  @override
  Future<BaseModel<GetDoctorTimeReserveResponseModel>> getDoctorTimeReserve(doctorId, date, minute) async {
    ArgumentError.checkNotNull(doctorId, 'doctorId');
    ArgumentError.checkNotNull(date, 'date');
    ArgumentError.checkNotNull(minute, 'minute');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'doctorId': doctorId, 'date': date, 'minute': minute};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('doctorInfo/v1.0.0/getDoctorTimeReserve',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: <String, dynamic>{}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value = BaseModel<GetDoctorTimeReserveResponseModel>.fromJson(
      _result.data,
      (json) => GetDoctorTimeReserveResponseModel.fromJson(json),
    );
    return value;
  }
}
