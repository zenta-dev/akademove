part of '_export.dart';

@MappableClass()
class Place with PlaceMappable {
  const Place({
    required this.name,
    required this.vicinity,
    required this.lat,
    required this.lng,
    required this.icon,
    this.distance,
  });

  factory Place.fromGooglePlace(Map<String, dynamic> json) {
    final geometry = json['geometry']?['location'];
    return Place(
      name: json['name'] as String? ?? '',
      vicinity:
          (json['vicinity'] as String?) ??
          (json['formatted_address'] as String?) ??
          '',
      lat: (geometry?['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (geometry?['lng'] as num?)?.toDouble() ?? 0.0,
      icon: json['icon'] as String? ?? '',
    );
  }

  final String name;
  final String vicinity;
  final double lat;
  final double lng;
  final String icon;
  final Distance? distance;

  Coordinate toCoordinate() {
    return Coordinate(x: lng, y: lat);
  }
}
