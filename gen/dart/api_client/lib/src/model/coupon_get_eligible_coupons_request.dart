//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon_get_eligible_coupons_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CouponGetEligibleCouponsRequest {
  /// Returns a new [CouponGetEligibleCouponsRequest] instance.
  const CouponGetEligibleCouponsRequest({
    required this.serviceType,
    required this.totalAmount,
     this.merchantId,
  });

  @JsonKey(name: r'serviceType', required: true, includeIfNull: false)
  final OrderType serviceType;
  
  @JsonKey(name: r'totalAmount', required: true, includeIfNull: false)
  final num totalAmount;
  
  @JsonKey(name: r'merchantId', required: false, includeIfNull: false)
  final String? merchantId;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is CouponGetEligibleCouponsRequest &&
    other.serviceType == serviceType &&
    other.totalAmount == totalAmount &&
    other.merchantId == merchantId;

  @override
  int get hashCode =>
      serviceType.hashCode +
      totalAmount.hashCode +
      merchantId.hashCode;

  factory CouponGetEligibleCouponsRequest.fromJson(Map<String, dynamic> json) => _$CouponGetEligibleCouponsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CouponGetEligibleCouponsRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

