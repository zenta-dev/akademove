//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_envelope_payload_retry_info.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderEnvelopePayloadRetryInfo {
  /// Returns a new [OrderEnvelopePayloadRetryInfo] instance.
  const OrderEnvelopePayloadRetryInfo({
    required this.orderId,
    required this.cancelledDriverId,
    required this.excludedDriverCount,
    this.reason,
  });
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'cancelledDriverId', required: true, includeIfNull: false)
  final String cancelledDriverId;

  @JsonKey(name: r'excludedDriverCount', required: true, includeIfNull: false)
  final num excludedDriverCount;

  @JsonKey(name: r'reason', required: false, includeIfNull: false)
  final String? reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderEnvelopePayloadRetryInfo &&
          other.orderId == orderId &&
          other.cancelledDriverId == cancelledDriverId &&
          other.excludedDriverCount == excludedDriverCount &&
          other.reason == reason;

  @override
  int get hashCode =>
      orderId.hashCode +
      cancelledDriverId.hashCode +
      excludedDriverCount.hashCode +
      reason.hashCode;

  factory OrderEnvelopePayloadRetryInfo.fromJson(Map<String, dynamic> json) =>
      _$OrderEnvelopePayloadRetryInfoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEnvelopePayloadRetryInfoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
