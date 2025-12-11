//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_envelope_payload_driver_update_location.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderEnvelopePayloadDriverUpdateLocation {
  /// Returns a new [OrderEnvelopePayloadDriverUpdateLocation] instance.
  const OrderEnvelopePayloadDriverUpdateLocation({
    required this.driverId,
    required this.x,
    required this.y,
  });
  @JsonKey(name: r'driverId', required: true, includeIfNull: false)
  final String driverId;
  
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
  bool operator ==(Object other) => identical(this, other) || other is OrderEnvelopePayloadDriverUpdateLocation &&
    other.driverId == driverId &&
    other.x == x &&
    other.y == y;

  @override
  int get hashCode =>
      driverId.hashCode +
      x.hashCode +
      y.hashCode;

  factory OrderEnvelopePayloadDriverUpdateLocation.fromJson(Map<String, dynamic> json) => _$OrderEnvelopePayloadDriverUpdateLocationFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEnvelopePayloadDriverUpdateLocationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

