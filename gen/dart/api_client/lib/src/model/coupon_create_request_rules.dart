//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coupon_create_request_rules_user.dart';
import 'package:api_client/src/model/coupon_create_request_rules_time.dart';
import 'package:api_client/src/model/coupon_create_request_rules_general.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon_create_request_rules.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CouponCreateRequestRules {
  /// Returns a new [CouponCreateRequestRules] instance.
  CouponCreateRequestRules({this.general, this.user, this.time});

  @JsonKey(name: r'general', required: false, includeIfNull: false)
  final CouponCreateRequestRulesGeneral? general;

  @JsonKey(name: r'user', required: false, includeIfNull: false)
  final CouponCreateRequestRulesUser? user;

  @JsonKey(name: r'time', required: false, includeIfNull: false)
  final CouponCreateRequestRulesTime? time;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CouponCreateRequestRules &&
          other.general == general &&
          other.user == user &&
          other.time == time;

  @override
  int get hashCode => general.hashCode + user.hashCode + time.hashCode;

  factory CouponCreateRequestRules.fromJson(Map<String, dynamic> json) =>
      _$CouponCreateRequestRulesFromJson(json);

  Map<String, dynamic> toJson() => _$CouponCreateRequestRulesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
