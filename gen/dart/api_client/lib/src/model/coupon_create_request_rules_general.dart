//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon_create_request_rules_general.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CouponCreateRequestRulesGeneral {
  /// Returns a new [CouponCreateRequestRulesGeneral] instance.
  CouponCreateRequestRulesGeneral({
    this.type,

    this.minOrderAmount,

    this.maxDiscountAmount,
  });

  @JsonKey(name: r'type', required: false, includeIfNull: false)
  final CouponCreateRequestRulesGeneralTypeEnum? type;

  // minimum: 0
  @JsonKey(name: r'minOrderAmount', required: false, includeIfNull: false)
  final num? minOrderAmount;

  // minimum: 0
  @JsonKey(name: r'maxDiscountAmount', required: false, includeIfNull: false)
  final num? maxDiscountAmount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CouponCreateRequestRulesGeneral &&
          other.type == type &&
          other.minOrderAmount == minOrderAmount &&
          other.maxDiscountAmount == maxDiscountAmount;

  @override
  int get hashCode =>
      type.hashCode + minOrderAmount.hashCode + maxDiscountAmount.hashCode;

  factory CouponCreateRequestRulesGeneral.fromJson(Map<String, dynamic> json) =>
      _$CouponCreateRequestRulesGeneralFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CouponCreateRequestRulesGeneralToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum CouponCreateRequestRulesGeneralTypeEnum {
  @JsonValue(r'percentage')
  percentage(r'percentage'),
  @JsonValue(r'fixed')
  fixed(r'fixed');

  const CouponCreateRequestRulesGeneralTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
