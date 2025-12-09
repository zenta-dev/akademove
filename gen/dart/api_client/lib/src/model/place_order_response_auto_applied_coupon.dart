//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'place_order_response_auto_applied_coupon.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PlaceOrderResponseAutoAppliedCoupon {
  /// Returns a new [PlaceOrderResponseAutoAppliedCoupon] instance.
  const PlaceOrderResponseAutoAppliedCoupon({
    required this.code,
    required this.discountAmount,
  });
  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'discountAmount', required: true, includeIfNull: false)
  final num discountAmount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceOrderResponseAutoAppliedCoupon &&
          other.code == code &&
          other.discountAmount == discountAmount;

  @override
  int get hashCode => code.hashCode + discountAmount.hashCode;

  factory PlaceOrderResponseAutoAppliedCoupon.fromJson(
    Map<String, dynamic> json,
  ) => _$PlaceOrderResponseAutoAppliedCouponFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PlaceOrderResponseAutoAppliedCouponToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
