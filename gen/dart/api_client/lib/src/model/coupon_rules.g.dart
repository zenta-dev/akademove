// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_rules.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponRulesCWProxy {
  CouponRules general(GeneralRules? general);

  CouponRules user(UserRules? user);

  CouponRules time(TimeRules? time);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponRules(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponRules(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponRules call({GeneralRules? general, UserRules? user, TimeRules? time});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCouponRules.copyWith(...)` or call `instanceOfCouponRules.copyWith.fieldName(value)` for a single field.
class _$CouponRulesCWProxyImpl implements _$CouponRulesCWProxy {
  const _$CouponRulesCWProxyImpl(this._value);

  final CouponRules _value;

  @override
  CouponRules general(GeneralRules? general) => call(general: general);

  @override
  CouponRules user(UserRules? user) => call(user: user);

  @override
  CouponRules time(TimeRules? time) => call(time: time);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponRules(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponRules(...).copyWith(id: 12, name: "My name")
  /// ```
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCouponRules.copyWith(...)` or `instanceOfCouponRules.copyWith.fieldName(...)`.
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
