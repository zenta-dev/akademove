// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_rules.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponRulesCWProxy {
  CouponRules general(CouponGeneralRules? general);

  CouponRules user(CouponUserRules? user);

  CouponRules time(CouponTimeRules? time);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponRules(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponRules(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponRules call({
    CouponGeneralRules? general,
    CouponUserRules? user,
    CouponTimeRules? time,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCouponRules.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCouponRules.copyWith.fieldName(...)`
class _$CouponRulesCWProxyImpl implements _$CouponRulesCWProxy {
  const _$CouponRulesCWProxyImpl(this._value);

  final CouponRules _value;

  @override
  CouponRules general(CouponGeneralRules? general) => this(general: general);

  @override
  CouponRules user(CouponUserRules? user) => this(user: user);

  @override
  CouponRules time(CouponTimeRules? time) => this(time: time);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponRules(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponRules(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponRules call({
    Object? general = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? time = const $CopyWithPlaceholder(),
  }) {
    return CouponRules(
      general: general == const $CopyWithPlaceholder()
          ? _value.general
          // ignore: cast_nullable_to_non_nullable
          : general as CouponGeneralRules?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as CouponUserRules?,
      time: time == const $CopyWithPlaceholder()
          ? _value.time
          // ignore: cast_nullable_to_non_nullable
          : time as CouponTimeRules?,
    );
  }
}

extension $CouponRulesCopyWith on CouponRules {
  /// Returns a callable class that can be used as follows: `instanceOfCouponRules.copyWith(...)` or like so:`instanceOfCouponRules.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponRulesCWProxy get copyWith => _$CouponRulesCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponRules _$CouponRulesFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CouponRules', json, ($checkedConvert) {
      final val = CouponRules(
        general: $checkedConvert(
          'general',
          (v) => v == null
              ? null
              : CouponGeneralRules.fromJson(v as Map<String, dynamic>),
        ),
        user: $checkedConvert(
          'user',
          (v) => v == null
              ? null
              : CouponUserRules.fromJson(v as Map<String, dynamic>),
        ),
        time: $checkedConvert(
          'time',
          (v) => v == null
              ? null
              : CouponTimeRules.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CouponRulesToJson(CouponRules instance) =>
    <String, dynamic>{
      'general': ?instance.general?.toJson(),
      'user': ?instance.user?.toJson(),
      'time': ?instance.time?.toJson(),
    };
