//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'refund_job_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RefundJobPayload {
  /// Returns a new [RefundJobPayload] instance.
  const RefundJobPayload({
    required this.orderId,
    required this.userId,
    required this.walletId,
    required this.paymentId,
    required this.transactionId,
    required this.refundAmount,
    this.penaltyAmount = 0,
    required this.reason,
    required this.refundType,
  });
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'walletId', required: true, includeIfNull: false)
  final String walletId;

  @JsonKey(name: r'paymentId', required: true, includeIfNull: false)
  final String paymentId;

  @JsonKey(name: r'transactionId', required: true, includeIfNull: false)
  final String transactionId;

  @JsonKey(name: r'refundAmount', required: true, includeIfNull: false)
  final num refundAmount;

  // minimum: 0
  @JsonKey(
    defaultValue: 0,
    name: r'penaltyAmount',
    required: false,
    includeIfNull: false,
  )
  final num? penaltyAmount;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @JsonKey(name: r'refundType', required: true, includeIfNull: false)
  final RefundJobPayloadRefundTypeEnum refundType;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RefundJobPayload &&
          other.orderId == orderId &&
          other.userId == userId &&
          other.walletId == walletId &&
          other.paymentId == paymentId &&
          other.transactionId == transactionId &&
          other.refundAmount == refundAmount &&
          other.penaltyAmount == penaltyAmount &&
          other.reason == reason &&
          other.refundType == refundType;

  @override
  int get hashCode =>
      orderId.hashCode +
      userId.hashCode +
      walletId.hashCode +
      paymentId.hashCode +
      transactionId.hashCode +
      refundAmount.hashCode +
      penaltyAmount.hashCode +
      reason.hashCode +
      refundType.hashCode;

  factory RefundJobPayload.fromJson(Map<String, dynamic> json) =>
      _$RefundJobPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$RefundJobPayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum RefundJobPayloadRefundTypeEnum {
  @JsonValue(r'FULL_REFUND')
  FULL_REFUND(r'FULL_REFUND'),
  @JsonValue(r'PARTIAL_REFUND')
  PARTIAL_REFUND(r'PARTIAL_REFUND'),
  @JsonValue(r'NO_SHOW_REFUND')
  NO_SHOW_REFUND(r'NO_SHOW_REFUND'),
  @JsonValue(r'SYSTEM_CANCEL_REFUND')
  SYSTEM_CANCEL_REFUND(r'SYSTEM_CANCEL_REFUND'),
  @JsonValue(r'USER_CANCEL_REFUND')
  USER_CANCEL_REFUND(r'USER_CANCEL_REFUND'),
  @JsonValue(r'DRIVER_CANCEL_REFUND')
  DRIVER_CANCEL_REFUND(r'DRIVER_CANCEL_REFUND');

  const RefundJobPayloadRefundTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
