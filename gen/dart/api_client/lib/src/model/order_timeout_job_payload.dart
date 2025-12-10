//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_timeout_job_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderTimeoutJobPayload {
  /// Returns a new [OrderTimeoutJobPayload] instance.
  const OrderTimeoutJobPayload({
    required this.orderId,
    required this.userId,
    this.paymentId,
    required this.totalPrice,
    this.timeoutReason = 'No driver available within timeout period',
    this.processRefund = true,
  });
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'paymentId', required: false, includeIfNull: false)
  final String? paymentId;

  @JsonKey(name: r'totalPrice', required: true, includeIfNull: false)
  final num totalPrice;

  @JsonKey(
    defaultValue: 'No driver available within timeout period',
    name: r'timeoutReason',
    required: false,
    includeIfNull: false,
  )
  final String? timeoutReason;

  @JsonKey(
    defaultValue: true,
    name: r'processRefund',
    required: false,
    includeIfNull: false,
  )
  final bool? processRefund;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderTimeoutJobPayload &&
          other.orderId == orderId &&
          other.userId == userId &&
          other.paymentId == paymentId &&
          other.totalPrice == totalPrice &&
          other.timeoutReason == timeoutReason &&
          other.processRefund == processRefund;

  @override
  int get hashCode =>
      orderId.hashCode +
      userId.hashCode +
      paymentId.hashCode +
      totalPrice.hashCode +
      timeoutReason.hashCode +
      processRefund.hashCode;

  factory OrderTimeoutJobPayload.fromJson(Map<String, dynamic> json) =>
      _$OrderTimeoutJobPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$OrderTimeoutJobPayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
