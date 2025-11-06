// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_time_rules.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponTimeRulesCWProxy {
  CouponTimeRules allowedDays(List<DayOfWeek>? allowedDays);

  CouponTimeRules allowedHours(List<int>? allowedHours);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponTimeRules(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponTimeRules(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponTimeRules call({List<DayOfWeek>? allowedDays, List<int>? allowedHours});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCouponTimeRules.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCouponTimeRules.copyWith.fieldName(...)`
class _$CouponTimeRulesCWProxyImpl implements _$CouponTimeRulesCWProxy {
  const _$CouponTimeRulesCWProxyImpl(this._value);

  final CouponTimeRules _value;

  @override
  CouponTimeRules allowedDays(List<DayOfWeek>? allowedDays) =>
      this(allowedDays: allowedDays);

  @override
  CouponTimeRules allowedHours(List<int>? allowedHours) =>
      this(allowedHours: allowedHours);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponTimeRules(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponTimeRules(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponTimeRules call({
    Object? allowedDays = const $CopyWithPlaceholder(),
    Object? allowedHours = const $CopyWithPlaceholder(),
  }) {
    return CouponTimeRules(
      allowedDays: allowedDays == const $CopyWithPlaceholder()
          ? _value.allowedDays
          // ignore: cast_nullable_to_non_nullable
          : allowedDays as List<DayOfWeek>?,
      allowedHours: allowedHours == const $CopyWithPlaceholder()
          ? _value.allowedHours
          // ignore: cast_nullable_to_non_nullable
          : allowedHours as List<int>?,
    );
  }
}

extension $CouponTimeRulesCopyWith on CouponTimeRules {
  /// Returns a callable class that can be used as follows: `instanceOfCouponTimeRules.copyWith(...)` or like so:`instanceOfCouponTimeRules.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponTimeRulesCWProxy get copyWith => _$CouponTimeRulesCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponTimeRules _$CouponTimeRulesFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CouponTimeRules', json, ($checkedConvert) {
      final val = CouponTimeRules(
        allowedDays: $checkedConvert(
          'allowedDays',
          (v) => (v as List<dynamic>?)
              ?.map((e) => $enumDecode(_$DayOfWeekEnumMap, e))
              .toList(),
        ),
        allowedHours: $checkedConvert(
          'allowedHours',
          (v) => (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CouponTimeRulesToJson(CouponTimeRules instance) =>
    <String, dynamic>{
      'allowedDays': ?instance.allowedDays
          ?.map((e) => _$DayOfWeekEnumMap[e]!)
          .toList(),
      'allowedHours': ?instance.allowedHours,
    };

const _$DayOfWeekEnumMap = {
  DayOfWeek.sunday: 'sunday',
  DayOfWeek.monday: 'monday',
  DayOfWeek.tuesday: 'tuesday',
  DayOfWeek.wednesday: 'wednesday',
  DayOfWeek.thursday: 'thursday',
  DayOfWeek.friday: 'friday',
  DayOfWeek.saturday: 'saturday',
};
