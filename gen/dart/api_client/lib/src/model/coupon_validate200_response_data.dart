//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coupon.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon_validate200_response_data.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class CouponValidate200ResponseData {
  /// Returns a new [CouponValidate200ResponseData] instance.
  const CouponValidate200ResponseData({
    required this.valid,
    this.coupon,
    required this.discountAmount,
    required this.finalAmount,
    this.reason,
  });

  @JsonKey(name: r'valid', required: true, includeIfNull: false)
  final bool valid;

  @JsonKey(name: r'coupon', required: false, includeIfNull: false)
  final Coupon? coupon;

  @JsonKey(name: r'discountAmount', required: true, includeIfNull: false)
  final num discountAmount;

  @JsonKey(name: r'finalAmount', required: true, includeIfNull: false)
  final num finalAmount;

  @JsonKey(name: r'reason', required: false, includeIfNull: false)
  final String? reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CouponValidate200ResponseData &&
          other.valid == valid &&
          other.coupon == coupon &&
          other.discountAmount == discountAmount &&
          other.finalAmount == finalAmount &&
          other.reason == reason;

  @override
  int get hashCode =>
      valid.hashCode +
      (coupon == null ? 0 : coupon.hashCode) +
      discountAmount.hashCode +
      finalAmount.hashCode +
      reason.hashCode;

  factory CouponValidate200ResponseData.fromJson(Map<String, dynamic> json) =>
      _$CouponValidate200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CouponValidate200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
