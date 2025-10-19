//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coupon_user_rules.dart';
import 'package:api_client/src/model/coupon_general_rules.dart';
import 'package:api_client/src/model/coupon_time_rules.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon_rules.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CouponRules {
  /// Returns a new [CouponRules] instance.
  CouponRules({this.general, this.user, this.time});

  @JsonKey(name: r'general', required: false, includeIfNull: false)
  final CouponGeneralRules? general;

  @JsonKey(name: r'user', required: false, includeIfNull: false)
  final CouponUserRules? user;

  @JsonKey(name: r'time', required: false, includeIfNull: false)
  final CouponTimeRules? time;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CouponRules &&
          other.general == general &&
          other.user == user &&
          other.time == time;

  @override
  int get hashCode => general.hashCode + user.hashCode + time.hashCode;

  factory CouponRules.fromJson(Map<String, dynamic> json) =>
      _$CouponRulesFromJson(json);

  Map<String, dynamic> toJson() => _$CouponRulesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
