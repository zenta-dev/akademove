// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_driver_schedule_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateDriverScheduleRequestCWProxy {
  UpdateDriverScheduleRequest name(String? name);

  UpdateDriverScheduleRequest dayOfWeek(DayOfWeek? dayOfWeek);

  UpdateDriverScheduleRequest startTime(Time? startTime);

  UpdateDriverScheduleRequest endTime(Time? endTime);

  UpdateDriverScheduleRequest isRecurring(bool? isRecurring);

  UpdateDriverScheduleRequest specificDate(DateTime? specificDate);

  UpdateDriverScheduleRequest isActive(bool? isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateDriverScheduleRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateDriverScheduleRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateDriverScheduleRequest call({
    String? name,
    DayOfWeek? dayOfWeek,
    Time? startTime,
    Time? endTime,
    bool? isRecurring,
    DateTime? specificDate,
    bool? isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateDriverScheduleRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateDriverScheduleRequest.copyWith.fieldName(...)`
class _$UpdateDriverScheduleRequestCWProxyImpl
    implements _$UpdateDriverScheduleRequestCWProxy {
  const _$UpdateDriverScheduleRequestCWProxyImpl(this._value);

  final UpdateDriverScheduleRequest _value;

  @override
  UpdateDriverScheduleRequest name(String? name) => this(name: name);

  @override
  UpdateDriverScheduleRequest dayOfWeek(DayOfWeek? dayOfWeek) =>
      this(dayOfWeek: dayOfWeek);

  @override
  UpdateDriverScheduleRequest startTime(Time? startTime) =>
      this(startTime: startTime);

  @override
  UpdateDriverScheduleRequest endTime(Time? endTime) => this(endTime: endTime);

  @override
  UpdateDriverScheduleRequest isRecurring(bool? isRecurring) =>
      this(isRecurring: isRecurring);

  @override
  UpdateDriverScheduleRequest specificDate(DateTime? specificDate) =>
      this(specificDate: specificDate);

  @override
  UpdateDriverScheduleRequest isActive(bool? isActive) =>
      this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateDriverScheduleRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateDriverScheduleRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateDriverScheduleRequest call({
    Object? name = const $CopyWithPlaceholder(),
    Object? dayOfWeek = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? isRecurring = const $CopyWithPlaceholder(),
    Object? specificDate = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return UpdateDriverScheduleRequest(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      dayOfWeek: dayOfWeek == const $CopyWithPlaceholder()
          ? _value.dayOfWeek
          // ignore: cast_nullable_to_non_nullable
          : dayOfWeek as DayOfWeek?,
      startTime: startTime == const $CopyWithPlaceholder()
          ? _value.startTime
          // ignore: cast_nullable_to_non_nullable
          : startTime as Time?,
      endTime: endTime == const $CopyWithPlaceholder()
          ? _value.endTime
          // ignore: cast_nullable_to_non_nullable
          : endTime as Time?,
      isRecurring: isRecurring == const $CopyWithPlaceholder()
          ? _value.isRecurring
          // ignore: cast_nullable_to_non_nullable
          : isRecurring as bool?,
      specificDate: specificDate == const $CopyWithPlaceholder()
          ? _value.specificDate
          // ignore: cast_nullable_to_non_nullable
          : specificDate as DateTime?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
    );
  }
}

extension $UpdateDriverScheduleRequestCopyWith on UpdateDriverScheduleRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateDriverScheduleRequest.copyWith(...)` or like so:`instanceOfUpdateDriverScheduleRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateDriverScheduleRequestCWProxy get copyWith =>
      _$UpdateDriverScheduleRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateDriverScheduleRequest _$UpdateDriverScheduleRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpdateDriverScheduleRequest', json, ($checkedConvert) {
  final val = UpdateDriverScheduleRequest(
    name: $checkedConvert('name', (v) => v as String?),
    dayOfWeek: $checkedConvert(
      'dayOfWeek',
      (v) => $enumDecodeNullable(_$DayOfWeekEnumMap, v),
    ),
    startTime: $checkedConvert(
      'startTime',
      (v) => v == null ? null : Time.fromJson(v as Map<String, dynamic>),
    ),
    endTime: $checkedConvert(
      'endTime',
      (v) => v == null ? null : Time.fromJson(v as Map<String, dynamic>),
    ),
    isRecurring: $checkedConvert('isRecurring', (v) => v as bool? ?? true),
    specificDate: $checkedConvert(
      'specificDate',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    isActive: $checkedConvert('isActive', (v) => v as bool? ?? true),
  );
  return val;
});

Map<String, dynamic> _$UpdateDriverScheduleRequestToJson(
  UpdateDriverScheduleRequest instance,
) => <String, dynamic>{
  'name': ?instance.name,
  'dayOfWeek': ?_$DayOfWeekEnumMap[instance.dayOfWeek],
  'startTime': ?instance.startTime?.toJson(),
  'endTime': ?instance.endTime?.toJson(),
  'isRecurring': ?instance.isRecurring,
  'specificDate': ?instance.specificDate?.toIso8601String(),
  'isActive': ?instance.isActive,
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
