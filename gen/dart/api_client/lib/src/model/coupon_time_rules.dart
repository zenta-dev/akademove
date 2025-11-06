//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/day_of_week.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon_time_rules.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CouponTimeRules {
  /// Returns a new [CouponTimeRules] instance.
  const CouponTimeRules({this.allowedDays, this.allowedHours});

  @JsonKey(name: r'allowedDays', required: false, includeIfNull: false)
  final List<DayOfWeek>? allowedDays;

  @JsonKey(name: r'allowedHours', required: false, includeIfNull: false)
  final List<int>? allowedHours;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CouponTimeRules &&
          other.allowedDays == allowedDays &&
          other.allowedHours == allowedHours;

  @override
  int get hashCode => allowedDays.hashCode + allowedHours.hashCode;

  factory CouponTimeRules.fromJson(Map<String, dynamic> json) =>
      _$CouponTimeRulesFromJson(json);

  Map<String, dynamic> toJson() => _$CouponTimeRulesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
