//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon_general_rules.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CouponGeneralRules {
  /// Returns a new [CouponGeneralRules] instance.
  CouponGeneralRules({this.type, this.minOrderAmount, this.maxDiscountAmount});

  @JsonKey(name: r'type', required: false, includeIfNull: false)
  final CouponGeneralRulesTypeEnum? type;

  // minimum: 0
  @JsonKey(name: r'minOrderAmount', required: false, includeIfNull: false)
  final num? minOrderAmount;

  // minimum: 0
  @JsonKey(name: r'maxDiscountAmount', required: false, includeIfNull: false)
  final num? maxDiscountAmount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CouponGeneralRules &&
          other.type == type &&
          other.minOrderAmount == minOrderAmount &&
          other.maxDiscountAmount == maxDiscountAmount;

  @override
  int get hashCode =>
      type.hashCode + minOrderAmount.hashCode + maxDiscountAmount.hashCode;

  factory CouponGeneralRules.fromJson(Map<String, dynamic> json) =>
      _$CouponGeneralRulesFromJson(json);

  Map<String, dynamic> toJson() => _$CouponGeneralRulesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum CouponGeneralRulesTypeEnum {
  @JsonValue(r'percentage')
  percentage(r'percentage'),
  @JsonValue(r'fixed')
  fixed(r'fixed');

  const CouponGeneralRulesTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
