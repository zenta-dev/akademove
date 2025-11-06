import 'dart:math' show atan2, cos, pi, sin, sqrt;
import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

abstract class MapService extends BaseService {
  Future<PageTokenPaginationResult<List<Place>>> nearbyLocation(
    Coordinate coordinate, {
    int radius = 1000,
    String type = 'point_of_interest',
    int limit = 10,
    String? nextPageToken,
  });
  Future<PageTokenPaginationResult<List<Place>>> searchPlace(
    String query, {
    int limit = 10,
    String? nextPageToken,
    Coordinate? coordinate,
  });
}

class IMapService implements MapService {
  late final Dio _http;
  late final String _apiKey;

  static const _baseUrl = 'https://maps.googleapis.com/maps/api';
  static const _defaultTimeout = Duration(seconds: 10);

  @override
  Future<MapService> setup() async {
    _apiKey = MapConstants.apiKey;

    if (_apiKey.isEmpty) {
      throw const ServiceError(
        'Google Maps API key is not configured',
        code: ErrorCode.unknown,
      );
    }

    _http = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: _defaultTimeout,
        receiveTimeout: _defaultTimeout,
        validateStatus: (status) => status != null && status < 500,
      ),
    )..interceptors.add(LoggerInterceptor());

    return this;
  }

  @override
  void teardown() => _http.close(force: true);

  @override
  Future<PageTokenPaginationResult<List<Place>>> nearbyLocation(
    Coordinate coordinate, {
    int radius = 1000,
    String type = 'point_of_interest',
    int limit = 10,
    String? nextPageToken,
  }) async {
    try {
      final response = await _http.get<Map<String, dynamic>>(
        '/place/nearbysearch/json',
        queryParameters: nextPageToken == null
            ? {
                'location': '${coordinate.y},${coordinate.x}',
                'radius': radius,
                'type': type,
                'key': _apiKey,
              }
            : {
                'pagetoken': nextPageToken,
                'key': _apiKey,
              },
      );

      if (response.data == null) {
        throw ServiceError(
          'Empty response from Google Places API',
          code: ErrorCode.fromIntOrUnknown(response.statusCode),
        );
      }

      final status = response.data!['status'] as String?;
      if (status != 'OK' && status != 'ZERO_RESULTS') {
        throw ServiceError(
          response.data!['error_message'] as String? ??
              'Google Places API Error: $status',
          code: ErrorCode.fromInt(response.statusCode),
        );
      }

      final results = <Place>[];
      if (response.data!['results'] case final List<dynamic> resultsList) {
        for (final json in resultsList.whereType<Map<String, dynamic>>()) {
          if (results.length >= limit) break;

          final place = Place.fromGooglePlace(json);
          final distanceMeters = haversineDistance(
            lat1: coordinate.y.toDouble(),
            lng1: coordinate.x.toDouble(),
            lat2: place.lat,
            lng2: place.lng,
          );
          results.add(
            place.copyWith(
              distance: Distance(
                value: distanceMeters,
                unit: DistanceUnit.m,
              ),
            ),
          );
        }
      }

      final nextToken = response.data!['next_page_token'] as String?;

      return PageTokenPaginationResult(
        data: results,
        token: nextToken,
      );
    } on DioException catch (e) {
      throw ServiceError(
        '${e.response?.data ?? e.message ?? 'Unknown error'}',
        code: ErrorCode.fromIntOrUnknown(e.response?.statusCode),
      );
    } catch (e, stackTrace) {
      throw ServiceError(
        'Unexpected error during place search: $e\n$stackTrace',
        code: ErrorCode.unknown,
      );
    }
  }

  @override
  Future<PageTokenPaginationResult<List<Place>>> searchPlace(
    String query, {
    int limit = 10,
    String? nextPageToken,
    Coordinate? coordinate,
  }) async {
    try {
      final response = await _http.get<Map<String, dynamic>>(
        '/place/textsearch/json',
        queryParameters: nextPageToken == null
            ? {
                'query': query,
                'key': _apiKey,
              }
            : {
                'pagetoken': nextPageToken,
                'key': _apiKey,
              },
      );

      if (response.data == null) {
        throw ServiceError(
          'Empty response from Google Places API',
          code: ErrorCode.fromIntOrUnknown(response.statusCode),
        );
      }

      final status = response.data!['status'] as String?;
      if (status != 'OK' && status != 'ZERO_RESULTS') {
        throw ServiceError(
          response.data!['error_message'] as String? ??
              'Google Places API Error: $status',
          code: ErrorCode.fromInt(response.statusCode),
        );
      }

      final results = <Place>[];
      if (response.data!['results'] case final List<dynamic> resultsList) {
        for (final json in resultsList.whereType<Map<String, dynamic>>()) {
          if (results.length >= limit) break;

          var place = Place.fromGooglePlace(json);
          if (coordinate != null) {
            final distanceMeters = haversineDistance(
              lat1: coordinate.y.toDouble(),
              lng1: coordinate.x.toDouble(),
              lat2: place.lat,
              lng2: place.lng,
            );
            place = place.copyWith(
              distance: Distance(
                value: distanceMeters,
                unit: DistanceUnit.m,
              ),
            );
          }
          results.add(place);
        }
      }

      final nextToken = response.data!['next_page_token'] as String?;

      return PageTokenPaginationResult(
        data: results,
        token: nextToken,
      );
    } on DioException catch (e) {
      throw ServiceError(
        '${e.response?.data ?? e.message ?? 'Unknown error'}',
        code: ErrorCode.fromIntOrUnknown(e.response?.statusCode),
      );
    } catch (e, stackTrace) {
      throw ServiceError(
        'Unexpected error during place search: $e\n$stackTrace',
        code: ErrorCode.unknown,
      );
    }
  }

  /// Compute straight-line distance (Haversine formula)
  double haversineDistance({
    required double lat1,
    required double lng1,
    required double lat2,
    required double lng2,
  }) {
    const R = 6371000;
    final dLat = (lat2 - lat1) * (pi / 180);
    final dLon = (lng2 - lng1) * (pi / 180);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * (pi / 180)) *
            cos(lat2 * (pi / 180)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    return R * 2 * atan2(sqrt(a), sqrt(1 - a));
  }
}
