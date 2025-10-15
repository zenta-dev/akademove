// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_create_request_rules.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponCreateRequestRulesCWProxy {
  CouponCreateRequestRules general(CouponCreateRequestRulesGeneral? general);

  CouponCreateRequestRules user(CouponCreateRequestRulesUser? user);

  CouponCreateRequestRules time(CouponCreateRequestRulesTime? time);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponCreateRequestRules(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponCreateRequestRules(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponCreateRequestRules call({
    CouponCreateRequestRulesGeneral? general,
    CouponCreateRequestRulesUser? user,
    CouponCreateRequestRulesTime? time,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCouponCreateRequestRules.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCouponCreateRequestRules.copyWith.fieldName(...)`
class _$CouponCreateRequestRulesCWProxyImpl
    implements _$CouponCreateRequestRulesCWProxy {
  const _$CouponCreateRequestRulesCWProxyImpl(this._value);

  final CouponCreateRequestRules _value;

  @override
  CouponCreateRequestRules general(CouponCreateRequestRulesGeneral? general) =>
      this(general: general);

  @override
  CouponCreateRequestRules user(CouponCreateRequestRulesUser? user) =>
      this(user: user);

  @override
  CouponCreateRequestRules time(CouponCreateRequestRulesTime? time) =>
      this(time: time);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponCreateRequestRules(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponCreateRequestRules(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponCreateRequestRules call({
    Object? general = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? time = const $CopyWithPlaceholder(),
  }) {
    return CouponCreateRequestRules(
      general: general == const $CopyWithPlaceholder()
          ? _value.general
          // ignore: cast_nullable_to_non_nullable
          : general as CouponCreateRequestRulesGeneral?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as CouponCreateRequestRulesUser?,
      time: time == const $CopyWithPlaceholder()
          ? _value.time
          // ignore: cast_nullable_to_non_nullable
          : time as CouponCreateRequestRulesTime?,
    );
  }
}

extension $CouponCreateRequestRulesCopyWith on CouponCreateRequestRules {
  /// Returns a callable class that can be used as follows: `instanceOfCouponCreateRequestRules.copyWith(...)` or like so:`instanceOfCouponCreateRequestRules.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponCreateRequestRulesCWProxy get copyWith =>
      _$CouponCreateRequestRulesCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponCreateRequestRules _$CouponCreateRequestRulesFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CouponCreateRequestRules', json, ($checkedConvert) {
  final val = CouponCreateRequestRules(
    general: $checkedConvert(
      'general',
      (v) => v == null
          ? null
          : CouponCreateRequestRulesGeneral.fromJson(v as Map<String, dynamic>),
    ),
    user: $checkedConvert(
      'user',
      (v) => v == null
          ? null
          : CouponCreateRequestRulesUser.fromJson(v as Map<String, dynamic>),
    ),
    time: $checkedConvert(
      'time',
      (v) => v == null
          ? null
          : CouponCreateRequestRulesTime.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$CouponCreateRequestRulesToJson(
  CouponCreateRequestRules instance,
) => <String, dynamic>{
  'general': ?instance.general?.toJson(),
  'user': ?instance.user?.toJson(),
  'time': ?instance.time?.toJson(),
};
