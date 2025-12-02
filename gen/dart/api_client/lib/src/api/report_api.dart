//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

// ignore: unused_import
import 'dart:convert';
import 'package:api_client/src/deserialize.dart';
import 'package:dio/dio.dart';

import 'package:api_client/src/model/badge_remove200_response.dart';
import 'package:api_client/src/model/insert_report.dart';
import 'package:api_client/src/model/pagination_mode.dart';
import 'package:api_client/src/model/pagination_order.dart';
import 'package:api_client/src/model/report_create200_response.dart';
import 'package:api_client/src/model/report_list200_response.dart';
import 'package:api_client/src/model/update_report.dart';

class ReportApi {
  final Dio _dio;

  const ReportApi(this._dio);

  /// reportCreate
  ///
  ///
  /// Parameters:
  /// * [insertReport]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ReportCreate200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ReportCreate200Response>> reportCreate({
    required InsertReport insertReport,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/reports';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'bearer_auth'},
        ],
        ...?extra,
      },
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      _bodyData = jsonEncode(insertReport);
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _options.compose(_dio.options, _path),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ReportCreate200Response? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<ReportCreate200Response, ReportCreate200Response>(
              rawData,
              'ReportCreate200Response',
              growable: true,
            );
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ReportCreate200Response>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// reportGet
  ///
  ///
  /// Parameters:
  /// * [id]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ReportCreate200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ReportCreate200Response>> reportGet({
    required String id,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/reports/{id}'.replaceAll(
      '{'
      r'id'
      '}',
      id.toString(),
    );
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'bearer_auth'},
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ReportCreate200Response? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<ReportCreate200Response, ReportCreate200Response>(
              rawData,
              'ReportCreate200Response',
              growable: true,
            );
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ReportCreate200Response>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// reportList
  ///
  ///
  /// Parameters:
  /// * [cursor]
  /// * [limit]
  /// * [direction]
  /// * [page]
  /// * [query]
  /// * [sortBy]
  /// * [order]
  /// * [mode]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ReportList200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ReportList200Response>> reportList({
    String? cursor,
    Object? limit,
    String? direction,
    Object? page,
    String? query,
    String? sortBy,
    PaginationOrder? order = PaginationOrder.desc,
    PaginationMode? mode = PaginationMode.offset,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/reports';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'bearer_auth'},
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (cursor != null) r'cursor': cursor,
      if (limit != null) r'limit': limit,
      if (direction != null) r'direction': direction,
      if (page != null) r'page': page,
      if (query != null) r'query': query,
      if (sortBy != null) r'sortBy': sortBy,
      if (order != null) r'order': order,
      if (mode != null) r'mode': mode,
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ReportList200Response? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<ReportList200Response, ReportList200Response>(rawData, 'ReportList200Response', growable: true);
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ReportList200Response>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// reportRemove
  ///
  ///
  /// Parameters:
  /// * [id]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [BadgeRemove200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<BadgeRemove200Response>> reportRemove({
    required String id,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/reports/{id}'.replaceAll(
      '{'
      r'id'
      '}',
      id.toString(),
    );
    final _options = Options(
      method: r'DELETE',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'bearer_auth'},
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    BadgeRemove200Response? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<BadgeRemove200Response, BadgeRemove200Response>(
              rawData,
              'BadgeRemove200Response',
              growable: true,
            );
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<BadgeRemove200Response>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// reportUpdate
  ///
  ///
  /// Parameters:
  /// * [id]
  /// * [updateReport]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ReportCreate200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ReportCreate200Response>> reportUpdate({
    required String id,
    required UpdateReport updateReport,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/reports/{id}'.replaceAll(
      '{'
      r'id'
      '}',
      id.toString(),
    );
    final _options = Options(
      method: r'PUT',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'bearer_auth'},
        ],
        ...?extra,
      },
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      _bodyData = jsonEncode(updateReport);
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _options.compose(_dio.options, _path),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ReportCreate200Response? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<ReportCreate200Response, ReportCreate200Response>(
              rawData,
              'ReportCreate200Response',
              growable: true,
            );
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ReportCreate200Response>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }
}
