//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon_user_rules.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CouponUserRules {
  /// Returns a new [CouponUserRules] instance.
  CouponUserRules({this.newUserOnly});

  @JsonKey(name: r'newUserOnly', required: false, includeIfNull: false)
  final bool? newUserOnly;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CouponUserRules && other.newUserOnly == newUserOnly;

  @override
  int get hashCode => newUserOnly.hashCode;

  factory CouponUserRules.fromJson(Map<String, dynamic> json) =>
      _$CouponUserRulesFromJson(json);

  Map<String, dynamic> toJson() => _$CouponUserRulesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
