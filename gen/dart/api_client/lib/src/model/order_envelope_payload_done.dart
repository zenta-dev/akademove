//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coordinate.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_envelope_payload_done.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderEnvelopePayloadDone {
  /// Returns a new [OrderEnvelopePayloadDone] instance.
  const OrderEnvelopePayloadDone({
    required this.by,
    required this.orderId,
    required this.driverId,
    required this.driverCurrentLocation,
  });

  @JsonKey(name: r'by', required: true, includeIfNull: false)
  final OrderEnvelopePayloadDoneByEnum by;

  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'driverId', required: true, includeIfNull: false)
  final String driverId;

  @JsonKey(name: r'driverCurrentLocation', required: true, includeIfNull: false)
  final Coordinate driverCurrentLocation;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderEnvelopePayloadDone &&
          other.by == by &&
          other.orderId == orderId &&
          other.driverId == driverId &&
          other.driverCurrentLocation == driverCurrentLocation;

  @override
  int get hashCode =>
      by.hashCode +
      orderId.hashCode +
      driverId.hashCode +
      driverCurrentLocation.hashCode;

  factory OrderEnvelopePayloadDone.fromJson(Map<String, dynamic> json) =>
      _$OrderEnvelopePayloadDoneFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEnvelopePayloadDoneToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum OrderEnvelopePayloadDoneByEnum {
  @JsonValue(r'USER')
  USER(r'USER'),
  @JsonValue(r'DRIVER')
  DRIVER(r'DRIVER');

  const OrderEnvelopePayloadDoneByEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
