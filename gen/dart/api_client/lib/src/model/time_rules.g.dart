// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_rules.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TimeRulesCWProxy {
  TimeRules allowedDays(List<DayOfWeek>? allowedDays);

  TimeRules allowedHours(List<int>? allowedHours);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TimeRules(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TimeRules(...).copyWith(id: 12, name: "My name")
  /// ```
  TimeRules call({List<DayOfWeek>? allowedDays, List<int>? allowedHours});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTimeRules.copyWith(...)` or call `instanceOfTimeRules.copyWith.fieldName(value)` for a single field.
class _$TimeRulesCWProxyImpl implements _$TimeRulesCWProxy {
  const _$TimeRulesCWProxyImpl(this._value);

  final TimeRules _value;

  @override
  TimeRules allowedDays(List<DayOfWeek>? allowedDays) => call(allowedDays: allowedDays);

  @override
  TimeRules allowedHours(List<int>? allowedHours) => call(allowedHours: allowedHours);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TimeRules(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TimeRules(...).copyWith(id: 12, name: "My name")
  /// ```
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTimeRules.copyWith(...)` or `instanceOfTimeRules.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TimeRulesCWProxy get copyWith => _$TimeRulesCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeRules _$TimeRulesFromJson(Map<String, dynamic> json) => $checkedCreate('TimeRules', json, ($checkedConvert) {
  final val = TimeRules(
    allowedDays: $checkedConvert(
      'allowedDays',
      (v) => (v as List<dynamic>?)?.map((e) => $enumDecode(_$DayOfWeekEnumMap, e)).toList(),
    ),
    allowedHours: $checkedConvert(
      'allowedHours',
      (v) => (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$TimeRulesToJson(TimeRules instance) => <String, dynamic>{
  'allowedDays': ?instance.allowedDays?.map((e) => _$DayOfWeekEnumMap[e]!).toList(),
  'allowedHours': ?instance.allowedHours,
};

const _$DayOfWeekEnumMap = {
  DayOfWeek.SUNDAY: 'SUNDAY',
  DayOfWeek.MONDAY: 'MONDAY',
  DayOfWeek.TUESDAY: 'TUESDAY',
  DayOfWeek.WEDNESDAY: 'WEDNESDAY',
  DayOfWeek.THURSDAY: 'THURSDAY',
  DayOfWeek.FRIDAY: 'FRIDAY',
  DayOfWeek.SATURDAY: 'SATURDAY',
};
