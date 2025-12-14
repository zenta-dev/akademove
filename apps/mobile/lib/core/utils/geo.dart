import "dart:math";

import "package:api_client/api_client.dart";

/// Minimum distance in meters before syncing driver location to server
/// and updating UI. This filters out GPS noise/jitter when the driver
/// is stationary or moving very slowly.
const double kMinLocationUpdateDistanceMeters = 3.0;

/// Calculate distance between two coordinates in meters using Haversine formula.
///
/// The Haversine formula determines the great-circle distance between two points
/// on a sphere given their longitudes and latitudes.
///
/// [from] - The starting coordinate (x = longitude, y = latitude)
/// [to] - The ending coordinate (x = longitude, y = latitude)
///
/// Returns the distance in meters.
double distanceInMeters(Coordinate from, Coordinate to) {
  const earthRadiusMeters = 6371000.0;

  final lat1 = from.y * pi / 180;
  final lat2 = to.y * pi / 180;
  final deltaLat = (to.y - from.y) * pi / 180;
  final deltaLng = (to.x - from.x) * pi / 180;

  final a =
      sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(lat1) * cos(lat2) * sin(deltaLng / 2) * sin(deltaLng / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadiusMeters * c;
}
