//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

// ignore: unused_import
import 'dart:convert';
import 'package:api_client/src/deserialize.dart';
import 'package:dio/dio.dart';

import 'package:api_client/src/model/badge_create200_response.dart';
import 'package:api_client/src/model/badge_list200_response.dart';
import 'package:api_client/src/model/badge_remove200_response.dart';
import 'package:api_client/src/model/badge_user_create200_response.dart';
import 'package:api_client/src/model/badge_user_create_request.dart';
import 'package:api_client/src/model/badge_user_list200_response.dart';
import 'package:api_client/src/model/badge_user_update_request.dart';
import 'package:api_client/src/model/pagination_mode.dart';
import 'package:api_client/src/model/pagination_order.dart';

class BadgeApi {

  final Dio _dio;

  const BadgeApi(this._dio);

  /// badgeCreate
  /// 
  ///
  /// Parameters:
  /// * [code] 
  /// * [name] 
  /// * [description] 
  /// * [type] 
  /// * [level] 
  /// * [targetRole] 
  /// * [isActive] 
  /// * [displayOrder] 
  /// * [criteriaMinOrders] 
  /// * [criteriaMinRating] 
  /// * [criteriaMinOnTimeRate] 
  /// * [criteriaMinStreak] 
  /// * [criteriaMinEarnings] 
  /// * [benefitsPriorityBoost] 
  /// * [benefitsCommissionReduction] 
  /// * [icon] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [BadgeCreate200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<BadgeCreate200Response>> badgeCreate({ 
    required String code,
    required String name,
    required String description,
    required String type,
    required String level,
    required String targetRole,
    required bool isActive,
    required int displayOrder,
    int? criteriaMinOrders,
    num? criteriaMinRating,
    num? criteriaMinOnTimeRate,
    int? criteriaMinStreak,
    num? criteriaMinEarnings,
    int? benefitsPriorityBoost,
    num? benefitsCommissionReduction,
    MultipartFile? icon,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/badges';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearer_auth',
          },
        ],
        ...?extra,
      },
      contentType: 'multipart/form-data',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
        _bodyData = FormData.fromMap(<String, dynamic>{
    r'code': code,
    r'name': name,
    r'description': description,
    r'type': type,
    r'level': level,
    r'targetRole': targetRole,
    if (criteriaMinOrders != null) r'criteria_minOrders': criteriaMinOrders,
    if (criteriaMinRating != null) r'criteria_minRating': criteriaMinRating,
    if (criteriaMinOnTimeRate != null) r'criteria_minOnTimeRate': criteriaMinOnTimeRate,
    if (criteriaMinStreak != null) r'criteria_minStreak': criteriaMinStreak,
    if (criteriaMinEarnings != null) r'criteria_minEarnings': criteriaMinEarnings,
    if (benefitsPriorityBoost != null) r'benefits_priorityBoost': benefitsPriorityBoost,
    if (benefitsCommissionReduction != null) r'benefits_commissionReduction': benefitsCommissionReduction,
    r'isActive': isActive,
    r'displayOrder': displayOrder,
    if (icon != null) r'icon':  icon ,
  });
  
    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
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

    BadgeCreate200Response? _responseData;

    try {
      final rawData = _response.data;
_responseData = rawData == null ? null : deserialize<BadgeCreate200Response, BadgeCreate200Response>(rawData, 'BadgeCreate200Response', growable: true);
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<BadgeCreate200Response>(
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

  /// badgeGet
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
  /// Returns a [Future] containing a [Response] with a [BadgeCreate200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<BadgeCreate200Response>> badgeGet({ 
    required String id,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/badges/{id}'.replaceAll('{' r'id' '}', id.toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearer_auth',
          },
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

    BadgeCreate200Response? _responseData;

    try {
      final rawData = _response.data;
_responseData = rawData == null ? null : deserialize<BadgeCreate200Response, BadgeCreate200Response>(rawData, 'BadgeCreate200Response', growable: true);
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<BadgeCreate200Response>(
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

  /// badgeList
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
  /// Returns a [Future] containing a [Response] with a [BadgeList200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<BadgeList200Response>> badgeList({ 
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
    final _path = r'/badges';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearer_auth',
          },
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

    BadgeList200Response? _responseData;

    try {
      final rawData = _response.data;
_responseData = rawData == null ? null : deserialize<BadgeList200Response, BadgeList200Response>(rawData, 'BadgeList200Response', growable: true);
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<BadgeList200Response>(
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

  /// badgeRemove
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
  Future<Response<BadgeRemove200Response>> badgeRemove({ 
    required String id,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/badges/{id}'.replaceAll('{' r'id' '}', id.toString());
    final _options = Options(
      method: r'DELETE',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearer_auth',
          },
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
_responseData = rawData == null ? null : deserialize<BadgeRemove200Response, BadgeRemove200Response>(rawData, 'BadgeRemove200Response', growable: true);
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

  /// badgeUpdate
  /// 
  ///
  /// Parameters:
  /// * [id] 
  /// * [code] 
  /// * [name] 
  /// * [description] 
  /// * [type] 
  /// * [level] 
  /// * [targetRole] 
  /// * [criteriaMinOrders] 
  /// * [criteriaMinRating] 
  /// * [criteriaMinOnTimeRate] 
  /// * [criteriaMinStreak] 
  /// * [criteriaMinEarnings] 
  /// * [benefitsPriorityBoost] 
  /// * [benefitsCommissionReduction] 
  /// * [isActive] 
  /// * [displayOrder] 
  /// * [icon] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [BadgeCreate200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<BadgeCreate200Response>> badgeUpdate({ 
    required String id,
    String? code,
    String? name,
    String? description,
    String? type,
    String? level,
    String? targetRole,
    int? criteriaMinOrders,
    num? criteriaMinRating,
    num? criteriaMinOnTimeRate,
    int? criteriaMinStreak,
    num? criteriaMinEarnings,
    int? benefitsPriorityBoost,
    num? benefitsCommissionReduction,
    bool? isActive,
    int? displayOrder,
    MultipartFile? icon,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/badges/{id}'.replaceAll('{' r'id' '}', id.toString());
    final _options = Options(
      method: r'PUT',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearer_auth',
          },
        ],
        ...?extra,
      },
      contentType: 'multipart/form-data',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
        _bodyData = FormData.fromMap(<String, dynamic>{
    if (code != null) r'code': code,
    if (name != null) r'name': name,
    if (description != null) r'description': description,
    if (type != null) r'type': type,
    if (level != null) r'level': level,
    if (targetRole != null) r'targetRole': targetRole,
    if (criteriaMinOrders != null) r'criteria_minOrders': criteriaMinOrders,
    if (criteriaMinRating != null) r'criteria_minRating': criteriaMinRating,
    if (criteriaMinOnTimeRate != null) r'criteria_minOnTimeRate': criteriaMinOnTimeRate,
    if (criteriaMinStreak != null) r'criteria_minStreak': criteriaMinStreak,
    if (criteriaMinEarnings != null) r'criteria_minEarnings': criteriaMinEarnings,
    if (benefitsPriorityBoost != null) r'benefits_priorityBoost': benefitsPriorityBoost,
    if (benefitsCommissionReduction != null) r'benefits_commissionReduction': benefitsCommissionReduction,
    if (isActive != null) r'isActive': isActive,
    if (displayOrder != null) r'displayOrder': displayOrder,
    if (icon != null) r'icon':  icon ,
  });
  
    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
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

    BadgeCreate200Response? _responseData;

    try {
      final rawData = _response.data;
_responseData = rawData == null ? null : deserialize<BadgeCreate200Response, BadgeCreate200Response>(rawData, 'BadgeCreate200Response', growable: true);
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<BadgeCreate200Response>(
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

  /// badgeUserCreate
  /// 
  ///
  /// Parameters:
  /// * [badgeUserCreateRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [BadgeUserCreate200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<BadgeUserCreate200Response>> badgeUserCreate({ 
    required BadgeUserCreateRequest badgeUserCreateRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/badges/user';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearer_auth',
          },
        ],
        ...?extra,
      },
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
        _bodyData=jsonEncode(badgeUserCreateRequest);
    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
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

    BadgeUserCreate200Response? _responseData;

    try {
      final rawData = _response.data;
_responseData = rawData == null ? null : deserialize<BadgeUserCreate200Response, BadgeUserCreate200Response>(rawData, 'BadgeUserCreate200Response', growable: true);
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<BadgeUserCreate200Response>(
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

  /// badgeUserGet
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
  /// Returns a [Future] containing a [Response] with a [BadgeUserCreate200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<BadgeUserCreate200Response>> badgeUserGet({ 
    required String id,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/badges/user/{id}'.replaceAll('{' r'id' '}', id.toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearer_auth',
          },
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

    BadgeUserCreate200Response? _responseData;

    try {
      final rawData = _response.data;
_responseData = rawData == null ? null : deserialize<BadgeUserCreate200Response, BadgeUserCreate200Response>(rawData, 'BadgeUserCreate200Response', growable: true);
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<BadgeUserCreate200Response>(
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

  /// badgeUserList
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
  /// Returns a [Future] containing a [Response] with a [BadgeUserList200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<BadgeUserList200Response>> badgeUserList({ 
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
    final _path = r'/badges/user';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearer_auth',
          },
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

    BadgeUserList200Response? _responseData;

    try {
      final rawData = _response.data;
_responseData = rawData == null ? null : deserialize<BadgeUserList200Response, BadgeUserList200Response>(rawData, 'BadgeUserList200Response', growable: true);
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<BadgeUserList200Response>(
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

  /// badgeUserRemove
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
  Future<Response<BadgeRemove200Response>> badgeUserRemove({ 
    required String id,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/badges/user/{id}'.replaceAll('{' r'id' '}', id.toString());
    final _options = Options(
      method: r'DELETE',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearer_auth',
          },
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
_responseData = rawData == null ? null : deserialize<BadgeRemove200Response, BadgeRemove200Response>(rawData, 'BadgeRemove200Response', growable: true);
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

  /// badgeUserUpdate
  /// 
  ///
  /// Parameters:
  /// * [id] 
  /// * [badgeUserUpdateRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [BadgeUserCreate200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<BadgeUserCreate200Response>> badgeUserUpdate({ 
    required String id,
    required BadgeUserUpdateRequest badgeUserUpdateRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/badges/user/{id}'.replaceAll('{' r'id' '}', id.toString());
    final _options = Options(
      method: r'PUT',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearer_auth',
          },
        ],
        ...?extra,
      },
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
        _bodyData=jsonEncode(badgeUserUpdateRequest);
    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
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

    BadgeUserCreate200Response? _responseData;

    try {
      final rawData = _response.data;
_responseData = rawData == null ? null : deserialize<BadgeUserCreate200Response, BadgeUserCreate200Response>(rawData, 'BadgeUserCreate200Response', growable: true);
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<BadgeUserCreate200Response>(
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
