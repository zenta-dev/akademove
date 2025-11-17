// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_rules.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TimeRulesCWProxy {
  TimeRules allowedDays(List<DayOfWeek>? allowedDays);

  TimeRules allowedHours(List<int>? allowedHours);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TimeRules(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TimeRules(...).copyWith(id: 12, name: "My name")
  /// ````
  TimeRules call({List<DayOfWeek>? allowedDays, List<int>? allowedHours});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTimeRules.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTimeRules.copyWith.fieldName(...)`
class _$TimeRulesCWProxyImpl implements _$TimeRulesCWProxy {
  const _$TimeRulesCWProxyImpl(this._value);

  final TimeRules _value;

  @override
  TimeRules allowedDays(List<DayOfWeek>? allowedDays) =>
      this(allowedDays: allowedDays);

  @override
  TimeRules allowedHours(List<int>? allowedHours) =>
      this(allowedHours: allowedHours);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TimeRules(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TimeRules(...).copyWith(id: 12, name: "My name")
  /// ````
  TimeRules call({
    Object? allowedDays = const $CopyWithPlaceholder(),
    Object? allowedHours = const $CopyWithPlaceholder(),
  }) {
    return TimeRules(
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

extension $TimeRulesCopyWith on TimeRules {
  /// Returns a callable class that can be used as follows: `instanceOfTimeRules.copyWith(...)` or like so:`instanceOfTimeRules.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TimeRulesCWProxy get copyWith => _$TimeRulesCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeRules _$TimeRulesFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TimeRules', json, ($checkedConvert) {
      final val = TimeRules(
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

Map<String, dynamic> _$TimeRulesToJson(TimeRules instance) => <String, dynamic>{
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
