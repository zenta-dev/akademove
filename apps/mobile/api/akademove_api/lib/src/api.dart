//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:dio/dio.dart';
import 'package:built_value/serializer.dart';
import 'package:akademove_api/src/serializers.dart';
import 'package:akademove_api/src/auth/api_key_auth.dart';
import 'package:akademove_api/src/auth/basic_auth.dart';
import 'package:akademove_api/src/auth/bearer_auth.dart';
import 'package:akademove_api/src/auth/oauth.dart';
import 'package:akademove_api/src/api/driver_api.dart';
import 'package:akademove_api/src/api/merchant_api.dart';
import 'package:akademove_api/src/api/order_api.dart';
import 'package:akademove_api/src/api/promo_api.dart';
import 'package:akademove_api/src/api/report_api.dart';
import 'package:akademove_api/src/api/review_api.dart';
import 'package:akademove_api/src/api/schedule_api.dart';

class AkademoveApi {
  static const String basePath = r'http://localhost:3000';

  final Dio dio;
  final Serializers serializers;

  AkademoveApi({
    Dio? dio,
    Serializers? serializers,
    String? basePathOverride,
    List<Interceptor>? interceptors,
  })  : this.serializers = serializers ?? standardSerializers,
        this.dio = dio ??
            Dio(BaseOptions(
              baseUrl: basePathOverride ?? basePath,
              connectTimeout: const Duration(milliseconds: 5000),
              receiveTimeout: const Duration(milliseconds: 3000),
            )) {
    if (interceptors == null) {
      this.dio.interceptors.addAll([
        OAuthInterceptor(),
        BasicAuthInterceptor(),
        BearerAuthInterceptor(),
        ApiKeyAuthInterceptor(),
      ]);
    } else {
      this.dio.interceptors.addAll(interceptors);
    }
  }

  void setOAuthToken(String name, String token) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is OAuthInterceptor)
              as OAuthInterceptor)
          .tokens[name] = token;
    }
  }

  void setBearerAuth(String name, String token) {
    if (this.dio.interceptors.any((i) => i is BearerAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BearerAuthInterceptor)
              as BearerAuthInterceptor)
          .tokens[name] = token;
    }
  }

  void setBasicAuth(String name, String username, String password) {
    if (this.dio.interceptors.any((i) => i is BasicAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BasicAuthInterceptor)
              as BasicAuthInterceptor)
          .authInfo[name] = BasicAuthInfo(username, password);
    }
  }

  void setApiKey(String name, String apiKey) {
    if (this.dio.interceptors.any((i) => i is ApiKeyAuthInterceptor)) {
      (this
                  .dio
                  .interceptors
                  .firstWhere((element) => element is ApiKeyAuthInterceptor)
              as ApiKeyAuthInterceptor)
          .apiKeys[name] = apiKey;
    }
  }

  /// Get DriverApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  DriverApi getDriverApi() {
    return DriverApi(dio, serializers);
  }

  /// Get MerchantApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MerchantApi getMerchantApi() {
    return MerchantApi(dio, serializers);
  }

  /// Get OrderApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  OrderApi getOrderApi() {
    return OrderApi(dio, serializers);
  }

  /// Get PromoApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PromoApi getPromoApi() {
    return PromoApi(dio, serializers);
  }

  /// Get ReportApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ReportApi getReportApi() {
    return ReportApi(dio, serializers);
  }

  /// Get ReviewApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ReviewApi getReviewApi() {
    return ReviewApi(dio, serializers);
  }

  /// Get ScheduleApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ScheduleApi getScheduleApi() {
    return ScheduleApi(dio, serializers);
  }
}
