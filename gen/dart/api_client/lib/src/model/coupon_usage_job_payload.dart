//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon_usage_job_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CouponUsageJobPayload {
  /// Returns a new [CouponUsageJobPayload] instance.
  const CouponUsageJobPayload({
    required this.couponId,
    required this.userId,
    required this.orderId,
    required this.discountAmount,
  });
  @JsonKey(name: r'couponId', required: true, includeIfNull: false)
  final String couponId;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'discountAmount', required: true, includeIfNull: false)
  final num discountAmount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CouponUsageJobPayload &&
          other.couponId == couponId &&
          other.userId == userId &&
          other.orderId == orderId &&
          other.discountAmount == discountAmount;

  @override
  int get hashCode =>
      couponId.hashCode +
      userId.hashCode +
      orderId.hashCode +
      discountAmount.hashCode;

  factory CouponUsageJobPayload.fromJson(Map<String, dynamic> json) =>
      _$CouponUsageJobPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CouponUsageJobPayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
