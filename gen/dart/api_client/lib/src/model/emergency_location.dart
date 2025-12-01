//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'emergency_location.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EmergencyLocation {
  /// Returns a new [EmergencyLocation] instance.
  const EmergencyLocation({
    required this.latitude,
    required this.longitude,
  });

  @JsonKey(name: r'latitude', required: true, includeIfNull: false)
  final num latitude;
  
  @JsonKey(name: r'longitude', required: true, includeIfNull: false)
  final num longitude;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is EmergencyLocation &&
    other.latitude == latitude &&
    other.longitude == longitude;

  @override
  int get hashCode =>
      latitude.hashCode +
      longitude.hashCode;

  factory EmergencyLocation.fromJson(Map<String, dynamic> json) => _$EmergencyLocationFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyLocationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

