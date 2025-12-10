//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_envelope_payload_done.dart';
import 'package:api_client/src/model/order_envelope_payload_detail.dart';
import 'package:api_client/src/model/order_envelope_payload_driver_update_location.dart';
import 'package:api_client/src/model/driver.dart';
import 'package:api_client/src/model/order_envelope_payload_merchant_action.dart';
import 'package:api_client/src/model/order_envelope_payload_no_show.dart';
import 'package:api_client/src/model/order_envelope_payload_message.dart';
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
    this.driverAssigned,
    this.driverUpdateLocation,
    this.done,
    this.message,
    this.merchantAction,
    this.cancelReason,
    this.noShow,
  });
  @JsonKey(name: r'detail', required: false, includeIfNull: false)
  final OrderEnvelopePayloadDetail? detail;

  @JsonKey(name: r'driverAssigned', required: false, includeIfNull: false)
  final Driver? driverAssigned;

  @JsonKey(name: r'driverUpdateLocation', required: false, includeIfNull: false)
  final OrderEnvelopePayloadDriverUpdateLocation? driverUpdateLocation;

  @JsonKey(name: r'done', required: false, includeIfNull: false)
  final OrderEnvelopePayloadDone? done;

  @JsonKey(name: r'message', required: false, includeIfNull: false)
  final OrderEnvelopePayloadMessage? message;

  @JsonKey(name: r'merchantAction', required: false, includeIfNull: false)
  final OrderEnvelopePayloadMerchantAction? merchantAction;

  @JsonKey(name: r'cancelReason', required: false, includeIfNull: false)
  final String? cancelReason;

  @JsonKey(name: r'noShow', required: false, includeIfNull: false)
  final OrderEnvelopePayloadNoShow? noShow;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderEnvelopePayload &&
          other.detail == detail &&
          other.driverAssigned == driverAssigned &&
          other.driverUpdateLocation == driverUpdateLocation &&
          other.done == done &&
          other.message == message &&
          other.merchantAction == merchantAction &&
          other.cancelReason == cancelReason &&
          other.noShow == noShow;

  @override
  int get hashCode =>
      detail.hashCode +
      driverAssigned.hashCode +
      driverUpdateLocation.hashCode +
      done.hashCode +
      message.hashCode +
      merchantAction.hashCode +
      (cancelReason == null ? 0 : cancelReason.hashCode) +
      noShow.hashCode;

  factory OrderEnvelopePayload.fromJson(Map<String, dynamic> json) =>
      _$OrderEnvelopePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEnvelopePayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
