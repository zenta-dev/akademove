// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_user_rules.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponUserRulesCWProxy {
  CouponUserRules newUserOnly(bool? newUserOnly);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponUserRules(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponUserRules(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponUserRules call({bool? newUserOnly});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCouponUserRules.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCouponUserRules.copyWith.fieldName(...)`
class _$CouponUserRulesCWProxyImpl implements _$CouponUserRulesCWProxy {
  const _$CouponUserRulesCWProxyImpl(this._value);

  final CouponUserRules _value;

  @override
  CouponUserRules newUserOnly(bool? newUserOnly) =>
      this(newUserOnly: newUserOnly);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponUserRules(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponUserRules(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponUserRules call({Object? newUserOnly = const $CopyWithPlaceholder()}) {
    return CouponUserRules(
      newUserOnly: newUserOnly == const $CopyWithPlaceholder()
          ? _value.newUserOnly
          // ignore: cast_nullable_to_non_nullable
          : newUserOnly as bool?,
    );
  }
}

extension $CouponUserRulesCopyWith on CouponUserRules {
  /// Returns a callable class that can be used as follows: `instanceOfCouponUserRules.copyWith(...)` or like so:`instanceOfCouponUserRules.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponUserRulesCWProxy get copyWith => _$CouponUserRulesCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponUserRules _$CouponUserRulesFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CouponUserRules', json, ($checkedConvert) {
      final val = CouponUserRules(
        newUserOnly: $checkedConvert('newUserOnly', (v) => v as bool?),
      );
      return val;
    });

Map<String, dynamic> _$CouponUserRulesToJson(CouponUserRules instance) =>
    <String, dynamic>{'newUserOnly': ?instance.newUserOnly};
