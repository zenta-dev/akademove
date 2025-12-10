//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_matching_job_payload_pickup_location.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverMatchingJobPayloadPickupLocation {
  /// Returns a new [DriverMatchingJobPayloadPickupLocation] instance.
  const DriverMatchingJobPayloadPickupLocation({
    required this.x,
    required this.y,
  });
  @JsonKey(name: r'x', required: true, includeIfNull: false)
  final num x;

  @JsonKey(name: r'y', required: true, includeIfNull: false)
  final num y;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverMatchingJobPayloadPickupLocation &&
          other.x == x &&
          other.y == y;

  @override
  int get hashCode => x.hashCode + y.hashCode;

  factory DriverMatchingJobPayloadPickupLocation.fromJson(
    Map<String, dynamic> json,
  ) => _$DriverMatchingJobPayloadPickupLocationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DriverMatchingJobPayloadPickupLocationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
