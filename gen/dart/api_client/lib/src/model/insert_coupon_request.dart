//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coupon_rules.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_coupon_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertCouponRequest {
  /// Returns a new [InsertCouponRequest] instance.
  InsertCouponRequest({
    required this.name,

    required this.code,

    required this.rules,

    this.discountAmount,

    this.discountPercentage,

    required this.usageLimit,

    required this.periodStart,

    required this.periodEnd,

    required this.isActive,
  });

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'rules', required: true, includeIfNull: false)
  final CouponRules rules;

  @JsonKey(name: r'discountAmount', required: false, includeIfNull: false)
  final num? discountAmount;

  @JsonKey(name: r'discountPercentage', required: false, includeIfNull: false)
  final num? discountPercentage;

  @JsonKey(name: r'usageLimit', required: true, includeIfNull: false)
  final num usageLimit;

  @JsonKey(name: r'periodStart', required: true, includeIfNull: false)
  final DateTime periodStart;

  @JsonKey(name: r'periodEnd', required: true, includeIfNull: false)
  final DateTime periodEnd;

  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsertCouponRequest &&
          other.name == name &&
          other.code == code &&
          other.rules == rules &&
          other.discountAmount == discountAmount &&
          other.discountPercentage == discountPercentage &&
          other.usageLimit == usageLimit &&
          other.periodStart == periodStart &&
          other.periodEnd == periodEnd &&
          other.isActive == isActive;

  @override
  int get hashCode =>
      name.hashCode +
      code.hashCode +
      rules.hashCode +
      discountAmount.hashCode +
      discountPercentage.hashCode +
      usageLimit.hashCode +
      periodStart.hashCode +
      periodEnd.hashCode +
      isActive.hashCode;

  factory InsertCouponRequest.fromJson(Map<String, dynamic> json) =>
      _$InsertCouponRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InsertCouponRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
