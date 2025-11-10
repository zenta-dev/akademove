import 'dart:math' show atan2, cos, pi, sin, sqrt;
import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

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

  Future<List<Coordinate>> getRoutes(Coordinate origin, Coordinate destination);

  Future<DistanceWithDuration?> routeDistance(
    Coordinate origin,
    Coordinate destination,
  );
}

class IMapService implements MapService {
  late final Dio _http;
  late final String _apiKey;
  late final PolylinePoints _polylinePoints;

  static const _baseUrl = 'https://maps.googleapis.com/maps/api';
  static const _timeout = Duration(seconds: 10);
  static const _earthRadiusMeters = 6371000.0;

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
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
        validateStatus: (s) => s != null && s < 500,
      ),
    )..interceptors.add(LoggerInterceptor());

    _polylinePoints = PolylinePoints(apiKey: _apiKey);

    return this;
  }

  @override
  void teardown() => _http.close(force: true);

  // ---------------------------------------------------------------------------
  // Nearby Search
  // ---------------------------------------------------------------------------

  @override
  Future<PageTokenPaginationResult<List<Place>>> nearbyLocation(
    Coordinate coordinate, {
    int radius = 1000,
    String type = 'point_of_interest',
    int limit = 10,
    String? nextPageToken,
  }) async {
    final params = _buildNearbySearchParams(
      coordinate: coordinate,
      radius: radius,
      type: type,
      nextPageToken: nextPageToken,
    );

    final data = await _getValidatedJson('/place/nearbysearch/json', params);
    final places = _parsePlacesWithDistance(data, coordinate, limit);

    return PageTokenPaginationResult(
      data: places,
      token: data['next_page_token'] as String?,
    );
  }

  Map<String, dynamic> _buildNearbySearchParams({
    required Coordinate coordinate,
    required int radius,
    required String type,
    String? nextPageToken,
  }) {
    if (nextPageToken != null) {
      return {'pagetoken': nextPageToken, 'key': _apiKey};
    }
    return {
      'location': '${coordinate.y},${coordinate.x}',
      'radius': radius,
      'type': type,
      'key': _apiKey,
    };
  }

  // ---------------------------------------------------------------------------
  // Text Search
  // ---------------------------------------------------------------------------

  @override
  Future<PageTokenPaginationResult<List<Place>>> searchPlace(
    String query, {
    int limit = 10,
    String? nextPageToken,
    Coordinate? coordinate,
  }) async {
    final params = nextPageToken == null
        ? {'query': query, 'key': _apiKey}
        : {'pagetoken': nextPageToken, 'key': _apiKey};

    final data = await _getValidatedJson('/place/textsearch/json', params);
    final places = _parsePlacesWithDistance(data, coordinate, limit);

    return PageTokenPaginationResult(
      data: places,
      token: data['next_page_token'] as String?,
    );
  }

  List<Place> _parsePlacesWithDistance(
    Map<String, dynamic> data,
    Coordinate? referencePoint,
    int limit,
  ) {
    final resultsList = (data['results'] as List?) ?? [];
    final places = <Place>[];

    for (final item
        in resultsList.take(limit).whereType<Map<String, dynamic>>()) {
      var place = Place.fromGooglePlace(item);

      if (referencePoint != null) {
        final distance = _calculateDistance(
          referencePoint,
          Coordinate(x: place.lng, y: place.lat),
        );
        place = place.copyWith(
          distance: Distance(value: distance, unit: DistanceUnit.m),
        );
      }
      places.add(place);
    }

    return places;
  }

  // ---------------------------------------------------------------------------
  // Route Polyline
  // ---------------------------------------------------------------------------

  @override
  Future<List<Coordinate>> getRoutes(
    Coordinate origin,
    Coordinate destination,
  ) async {
    try {
      final request = RoutesApiRequest(
        origin: PointLatLng(origin.y.toDouble(), origin.x.toDouble()),
        destination: PointLatLng(
          destination.y.toDouble(),
          destination.x.toDouble(),
        ),
        travelMode: TravelMode.twoWheeler,
        routingPreference: RoutingPreference.trafficAwareOptimal,
      );

      final response = await _polylinePoints.getRouteBetweenCoordinatesV2(
        request: request,
      );

      if (response.routes.isEmpty) return [];

      final route = response.routes.first;
      print('Duration: ${route.durationMinutes} minutes');
      print('Distance: ${route.distanceKm} km');

      return route.polylinePoints
              ?.map((p) => Coordinate(x: p.longitude, y: p.latitude))
              .toList() ??
          [];
    } catch (e) {
      throw ServiceError(
        'Failed to get routes: $e',
        code: ErrorCode.unknown,
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Route Distance Matrix
  // ---------------------------------------------------------------------------

  @override
  Future<DistanceWithDuration?> routeDistance(
    Coordinate origin,
    Coordinate destination,
  ) async {
    final params = {
      'origins': '${origin.y},${origin.x}',
      'destinations': '${destination.y},${destination.x}',
      'units': 'metric',
      'key': _apiKey,
    };

    final data = await _getValidatedJson('/distancematrix/json', params);

    return _parseDistanceMatrixResult(data, origin, destination);
  }

  DistanceWithDuration? _parseDistanceMatrixResult(
    Map<String, dynamic> data,
    Coordinate origin,
    Coordinate destination,
  ) {
    final element = data['rows']?[0]?['elements']?[0];
    if (element == null) return null;

    final distanceVal = element['distance']?['value'];
    final durationVal = element['duration']?['value'];

    if (distanceVal is num && durationVal is num) {
      return DistanceWithDuration(
        distanceVal / 1000,
        Duration(seconds: durationVal.toInt()),
      );
    }

    // Fallback to straight-line distance if no route data
    final fallbackMeters = _calculateDistance(origin, destination);
    return DistanceWithDuration(fallbackMeters / 1000, Duration.zero);
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Future<Map<String, dynamic>> _getValidatedJson(
    String endpoint,
    Map<String, dynamic> params,
  ) async {
    try {
      final response = await _http.get<Map<String, dynamic>>(
        endpoint,
        queryParameters: params,
      );
      final data = response.data ?? {};

      final status = data['status'] as String?;
      if (status != 'OK' && status != 'ZERO_RESULTS') {
        throw ServiceError(
          data['error_message'] as String? ?? 'Google Maps API Error: $status',
          code: ErrorCode.fromInt(response.statusCode),
        );
      }
      return data;
    } on DioException catch (e) {
      throw ServiceError(
        '${e.response?.data ?? e.message ?? 'Unknown Dio error'}',
        code: ErrorCode.fromIntOrUnknown(e.response?.statusCode),
      );
    } catch (e) {
      throw ServiceError(
        'Unexpected API error: $e',
        code: ErrorCode.unknown,
      );
    }
  }

  /// Compute straight-line distance using the Haversine formula.
  double _calculateDistance(Coordinate from, Coordinate to) {
    final lat1Rad = from.y * (pi / 180);
    final lat2Rad = to.y * (pi / 180);
    final dLat = (to.y - from.y) * (pi / 180);
    final dLon = (to.x - from.x) * (pi / 180);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);

    return _earthRadiusMeters * 2 * atan2(sqrt(a), sqrt(1 - a));
  }
}

class DistanceWithDuration {
  const DistanceWithDuration(this.km, this.duration);
  final double km;
  final Duration duration;
}
