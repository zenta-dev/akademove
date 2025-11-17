// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_rules.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponRulesCWProxy {
  CouponRules general(GeneralRules? general);

  CouponRules user(UserRules? user);

  CouponRules time(TimeRules? time);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponRules(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponRules(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponRules call({GeneralRules? general, UserRules? user, TimeRules? time});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCouponRules.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCouponRules.copyWith.fieldName(...)`
class _$CouponRulesCWProxyImpl implements _$CouponRulesCWProxy {
  const _$CouponRulesCWProxyImpl(this._value);

  final CouponRules _value;

  @override
  CouponRules general(GeneralRules? general) => this(general: general);

  @override
  CouponRules user(UserRules? user) => this(user: user);

  @override
  CouponRules time(TimeRules? time) => this(time: time);

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
          : general as GeneralRules?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as UserRules?,
      time: time == const $CopyWithPlaceholder()
          ? _value.time
          // ignore: cast_nullable_to_non_nullable
          : time as TimeRules?,
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

CouponRules _$CouponRulesFromJson(Map<String, dynamic> json) => $checkedCreate(
  'CouponRules',
  json,
  ($checkedConvert) {
    final val = CouponRules(
      general: $checkedConvert(
        'general',
        (v) =>
            v == null ? null : GeneralRules.fromJson(v as Map<String, dynamic>),
      ),
      user: $checkedConvert(
        'user',
        (v) => v == null ? null : UserRules.fromJson(v as Map<String, dynamic>),
      ),
      time: $checkedConvert(
        'time',
        (v) => v == null ? null : TimeRules.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$CouponRulesToJson(CouponRules instance) =>
    <String, dynamic>{
      'general': ?instance.general?.toJson(),
      'user': ?instance.user?.toJson(),
      'time': ?instance.time?.toJson(),
    };
