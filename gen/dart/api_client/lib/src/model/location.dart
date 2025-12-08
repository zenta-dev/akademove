//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'location.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Location {
  /// Returns a new [Location] instance.
  const Location({required this.lat, required this.lng});
  @JsonKey(name: r'lat', required: true, includeIfNull: false)
  final num lat;

  @JsonKey(name: r'lng', required: true, includeIfNull: false)
  final num lng;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location && other.lat == lat && other.lng == lng;

  @override
  int get hashCode => lat.hashCode + lng.hashCode;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
