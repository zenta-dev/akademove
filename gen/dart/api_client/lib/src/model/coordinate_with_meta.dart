//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coordinate_with_meta.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CoordinateWithMeta {
  /// Returns a new [CoordinateWithMeta] instance.
  const CoordinateWithMeta({
    required this.x,
    required this.y,
    this.isMockLocation,
  });

  /// Longitude (X-axis, East-West)
  // minimum: -180
  // maximum: 180
  @JsonKey(name: r'x', required: true, includeIfNull: false)
  final num x;

  /// Latitude (Y-axis, North-South)
  // minimum: -90
  // maximum: 90
  @JsonKey(name: r'y', required: true, includeIfNull: false)
  final num y;

  /// Whether the location is from a mock provider (Android only)
  @JsonKey(name: r'isMockLocation', required: false, includeIfNull: false)
  final bool? isMockLocation;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoordinateWithMeta &&
          other.x == x &&
          other.y == y &&
          other.isMockLocation == isMockLocation;

  @override
  int get hashCode => x.hashCode + y.hashCode + isMockLocation.hashCode;

  factory CoordinateWithMeta.fromJson(Map<String, dynamic> json) =>
      _$CoordinateWithMetaFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinateWithMetaToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
