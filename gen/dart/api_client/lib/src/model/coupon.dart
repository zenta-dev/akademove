//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coupon_rules.dart';
import 'package:api_client/src/model/coupon_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Coupon {
  /// Returns a new [Coupon] instance.
  const Coupon({
    required this.id,
    required this.name,
    required this.code,
     this.couponType = CouponType.GENERAL,
    required this.rules,
     this.discountAmount,
     this.discountPercentage,
    required this.usageLimit,
    required this.usedCount,
    required this.periodStart,
    required this.periodEnd,
    required this.isActive,
     this.merchantId,
     this.eventName,
     this.eventDescription,
    required this.createdById,
    required this.createdAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;
  
  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;
  
  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;
  
  @JsonKey(defaultValue: CouponType.GENERAL,name: r'couponType', required: false, includeIfNull: false)
  final CouponType? couponType;
  
  @JsonKey(name: r'rules', required: true, includeIfNull: false)
  final CouponRules rules;
  
  @JsonKey(name: r'discountAmount', required: false, includeIfNull: false)
  final num? discountAmount;
  
  @JsonKey(name: r'discountPercentage', required: false, includeIfNull: false)
  final num? discountPercentage;
  
  @JsonKey(name: r'usageLimit', required: true, includeIfNull: false)
  final num usageLimit;
  
  @JsonKey(name: r'usedCount', required: true, includeIfNull: false)
  final num usedCount;
  
  @JsonKey(name: r'periodStart', required: true, includeIfNull: false)
  final DateTime periodStart;
  
  @JsonKey(name: r'periodEnd', required: true, includeIfNull: false)
  final DateTime periodEnd;
  
  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;
  
  @JsonKey(name: r'merchantId', required: false, includeIfNull: false)
  final String? merchantId;
  
  @JsonKey(name: r'eventName', required: false, includeIfNull: false)
  final String? eventName;
  
  @JsonKey(name: r'eventDescription', required: false, includeIfNull: false)
  final String? eventDescription;
  
  @JsonKey(name: r'createdById', required: true, includeIfNull: false)
  final String createdById;
  
  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is Coupon &&
    other.id == id &&
    other.name == name &&
    other.code == code &&
    other.couponType == couponType &&
    other.rules == rules &&
    other.discountAmount == discountAmount &&
    other.discountPercentage == discountPercentage &&
    other.usageLimit == usageLimit &&
    other.usedCount == usedCount &&
    other.periodStart == periodStart &&
    other.periodEnd == periodEnd &&
    other.isActive == isActive &&
    other.merchantId == merchantId &&
    other.eventName == eventName &&
    other.eventDescription == eventDescription &&
    other.createdById == createdById &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
      id.hashCode +
      name.hashCode +
      code.hashCode +
      couponType.hashCode +
      rules.hashCode +
      discountAmount.hashCode +
      discountPercentage.hashCode +
      usageLimit.hashCode +
      usedCount.hashCode +
      periodStart.hashCode +
      periodEnd.hashCode +
      isActive.hashCode +
      (merchantId == null ? 0 : merchantId.hashCode) +
      eventName.hashCode +
      eventDescription.hashCode +
      createdById.hashCode +
      createdAt.hashCode;

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

