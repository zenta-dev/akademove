// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_schedule_update_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverScheduleUpdateRequestCWProxy {
  DriverScheduleUpdateRequest name(String? name);

  DriverScheduleUpdateRequest dayOfWeek(DayOfWeek? dayOfWeek);

  DriverScheduleUpdateRequest startTime(Time? startTime);

  DriverScheduleUpdateRequest endTime(Time? endTime);

  DriverScheduleUpdateRequest isRecurring(bool? isRecurring);

  DriverScheduleUpdateRequest specificDate(DateTime? specificDate);

  DriverScheduleUpdateRequest isActive(bool? isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverScheduleUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverScheduleUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverScheduleUpdateRequest call({
    String? name,
    DayOfWeek? dayOfWeek,
    Time? startTime,
    Time? endTime,
    bool? isRecurring,
    DateTime? specificDate,
    bool? isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDriverScheduleUpdateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDriverScheduleUpdateRequest.copyWith.fieldName(...)`
class _$DriverScheduleUpdateRequestCWProxyImpl
    implements _$DriverScheduleUpdateRequestCWProxy {
  const _$DriverScheduleUpdateRequestCWProxyImpl(this._value);

  final DriverScheduleUpdateRequest _value;

  @override
  DriverScheduleUpdateRequest name(String? name) => this(name: name);

  @override
  DriverScheduleUpdateRequest dayOfWeek(DayOfWeek? dayOfWeek) =>
      this(dayOfWeek: dayOfWeek);

  @override
  DriverScheduleUpdateRequest startTime(Time? startTime) =>
      this(startTime: startTime);

  @override
  DriverScheduleUpdateRequest endTime(Time? endTime) => this(endTime: endTime);

  @override
  DriverScheduleUpdateRequest isRecurring(bool? isRecurring) =>
      this(isRecurring: isRecurring);

  @override
  DriverScheduleUpdateRequest specificDate(DateTime? specificDate) =>
      this(specificDate: specificDate);

  @override
  DriverScheduleUpdateRequest isActive(bool? isActive) =>
      this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverScheduleUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverScheduleUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverScheduleUpdateRequest call({
    Object? name = const $CopyWithPlaceholder(),
    Object? dayOfWeek = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? isRecurring = const $CopyWithPlaceholder(),
    Object? specificDate = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return DriverScheduleUpdateRequest(
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

extension $DriverScheduleUpdateRequestCopyWith on DriverScheduleUpdateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfDriverScheduleUpdateRequest.copyWith(...)` or like so:`instanceOfDriverScheduleUpdateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverScheduleUpdateRequestCWProxy get copyWith =>
      _$DriverScheduleUpdateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverScheduleUpdateRequest _$DriverScheduleUpdateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverScheduleUpdateRequest', json, ($checkedConvert) {
  final val = DriverScheduleUpdateRequest(
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

Map<String, dynamic> _$DriverScheduleUpdateRequestToJson(
  DriverScheduleUpdateRequest instance,
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
