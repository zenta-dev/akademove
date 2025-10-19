// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_schedule_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateScheduleRequestCWProxy {
  UpdateScheduleRequest dayOfWeek(
    UpdateScheduleRequestDayOfWeekEnum? dayOfWeek,
  );

  UpdateScheduleRequest startTime(Time? startTime);

  UpdateScheduleRequest endTime(Time? endTime);

  UpdateScheduleRequest isRecurring(bool? isRecurring);

  UpdateScheduleRequest specificDate(DateTime? specificDate);

  UpdateScheduleRequest isActive(bool? isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateScheduleRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateScheduleRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateScheduleRequest call({
    UpdateScheduleRequestDayOfWeekEnum? dayOfWeek,
    Time? startTime,
    Time? endTime,
    bool? isRecurring,
    DateTime? specificDate,
    bool? isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateScheduleRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateScheduleRequest.copyWith.fieldName(...)`
class _$UpdateScheduleRequestCWProxyImpl
    implements _$UpdateScheduleRequestCWProxy {
  const _$UpdateScheduleRequestCWProxyImpl(this._value);

  final UpdateScheduleRequest _value;

  @override
  UpdateScheduleRequest dayOfWeek(
    UpdateScheduleRequestDayOfWeekEnum? dayOfWeek,
  ) => this(dayOfWeek: dayOfWeek);

  @override
  UpdateScheduleRequest startTime(Time? startTime) =>
      this(startTime: startTime);

  @override
  UpdateScheduleRequest endTime(Time? endTime) => this(endTime: endTime);

  @override
  UpdateScheduleRequest isRecurring(bool? isRecurring) =>
      this(isRecurring: isRecurring);

  @override
  UpdateScheduleRequest specificDate(DateTime? specificDate) =>
      this(specificDate: specificDate);

  @override
  UpdateScheduleRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateScheduleRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateScheduleRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateScheduleRequest call({
    Object? dayOfWeek = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? isRecurring = const $CopyWithPlaceholder(),
    Object? specificDate = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return UpdateScheduleRequest(
      dayOfWeek: dayOfWeek == const $CopyWithPlaceholder()
          ? _value.dayOfWeek
          // ignore: cast_nullable_to_non_nullable
          : dayOfWeek as UpdateScheduleRequestDayOfWeekEnum?,
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

extension $UpdateScheduleRequestCopyWith on UpdateScheduleRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateScheduleRequest.copyWith(...)` or like so:`instanceOfUpdateScheduleRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateScheduleRequestCWProxy get copyWith =>
      _$UpdateScheduleRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateScheduleRequest _$UpdateScheduleRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpdateScheduleRequest', json, ($checkedConvert) {
  final val = UpdateScheduleRequest(
    dayOfWeek: $checkedConvert(
      'dayOfWeek',
      (v) =>
          $enumDecodeNullable(_$UpdateScheduleRequestDayOfWeekEnumEnumMap, v),
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

Map<String, dynamic> _$UpdateScheduleRequestToJson(
  UpdateScheduleRequest instance,
) => <String, dynamic>{
  'dayOfWeek': ?_$UpdateScheduleRequestDayOfWeekEnumEnumMap[instance.dayOfWeek],
  'startTime': ?instance.startTime?.toJson(),
  'endTime': ?instance.endTime?.toJson(),
  'isRecurring': ?instance.isRecurring,
  'specificDate': ?instance.specificDate?.toIso8601String(),
  'isActive': ?instance.isActive,
};

const _$UpdateScheduleRequestDayOfWeekEnumEnumMap = {
  UpdateScheduleRequestDayOfWeekEnum.sunday: 'sunday',
  UpdateScheduleRequestDayOfWeekEnum.monday: 'monday',
  UpdateScheduleRequestDayOfWeekEnum.tuesday: 'tuesday',
  UpdateScheduleRequestDayOfWeekEnum.wednesday: 'wednesday',
  UpdateScheduleRequestDayOfWeekEnum.thursday: 'thursday',
  UpdateScheduleRequestDayOfWeekEnum.friday: 'friday',
  UpdateScheduleRequestDayOfWeekEnum.saturday: 'saturday',
};
