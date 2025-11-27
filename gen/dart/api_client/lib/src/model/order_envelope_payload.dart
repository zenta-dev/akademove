//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_envelope_payload_done.dart';
import 'package:api_client/src/model/order_envelope_payload_detail.dart';
import 'package:api_client/src/model/order_envelope_payload_driver_update_location.dart';
import 'package:api_client/src/model/driver.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_envelope_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderEnvelopePayload {
  /// Returns a new [OrderEnvelopePayload] instance.
  const OrderEnvelopePayload({
    this.detail,
    this.driverAccept,
    this.driverUpdateLocation,
    this.done,
  });

  @JsonKey(name: r'detail', required: false, includeIfNull: false)
  final OrderEnvelopePayloadDetail? detail;

  @JsonKey(name: r'driverAccept', required: false, includeIfNull: false)
  final Driver? driverAccept;

  @JsonKey(name: r'driverUpdateLocation', required: false, includeIfNull: false)
  final OrderEnvelopePayloadDriverUpdateLocation? driverUpdateLocation;

  @JsonKey(name: r'done', required: false, includeIfNull: false)
  final OrderEnvelopePayloadDone? done;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderEnvelopePayload &&
          other.detail == detail &&
          other.driverAccept == driverAccept &&
          other.driverUpdateLocation == driverUpdateLocation &&
          other.done == done;

  @override
  int get hashCode =>
      detail.hashCode +
      driverAccept.hashCode +
      driverUpdateLocation.hashCode +
      done.hashCode;

  factory OrderEnvelopePayload.fromJson(Map<String, dynamic> json) =>
      _$OrderEnvelopePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEnvelopePayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
