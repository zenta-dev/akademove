//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coordinate.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class Coordinate {
  /// Returns a new [Coordinate] instance.
  const Coordinate({required this.x, required this.y});

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

  @override
  bool operator ==(Object other) => identical(this, other) || other is Coordinate && other.x == x && other.y == y;

  @override
  int get hashCode => x.hashCode + y.hashCode;

  factory Coordinate.fromJson(Map<String, dynamic> json) => _$CoordinateFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinateToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
