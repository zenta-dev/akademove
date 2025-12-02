//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coupon.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon_get_eligible_coupons200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CouponGetEligibleCoupons200ResponseData {
  /// Returns a new [CouponGetEligibleCoupons200ResponseData] instance.
  const CouponGetEligibleCoupons200ResponseData({
    required this.coupons,
    required this.bestCoupon,
    required this.bestDiscountAmount,
  });

  @JsonKey(name: r'coupons', required: true, includeIfNull: false)
  final List<Coupon> coupons;
  
  @JsonKey(name: r'bestCoupon', required: true, includeIfNull: true)
  final Coupon? bestCoupon;
  
  @JsonKey(name: r'bestDiscountAmount', required: true, includeIfNull: false)
  final num bestDiscountAmount;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is CouponGetEligibleCoupons200ResponseData &&
    other.coupons == coupons &&
    other.bestCoupon == bestCoupon &&
    other.bestDiscountAmount == bestDiscountAmount;

  @override
  int get hashCode =>
      coupons.hashCode +
      (bestCoupon == null ? 0 : bestCoupon.hashCode) +
      bestDiscountAmount.hashCode;

  factory CouponGetEligibleCoupons200ResponseData.fromJson(Map<String, dynamic> json) => _$CouponGetEligibleCoupons200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CouponGetEligibleCoupons200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

