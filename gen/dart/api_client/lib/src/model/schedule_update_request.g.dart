// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_update_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ScheduleUpdateRequestCWProxy {
  ScheduleUpdateRequest dayOfWeek(
    ScheduleUpdateRequestDayOfWeekEnum? dayOfWeek,
  );

  ScheduleUpdateRequest startTime(Time? startTime);

  ScheduleUpdateRequest endTime(Time? endTime);

  ScheduleUpdateRequest isRecurring(bool? isRecurring);

  ScheduleUpdateRequest specificDate(DateTime? specificDate);

  ScheduleUpdateRequest isActive(bool? isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ScheduleUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ScheduleUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ScheduleUpdateRequest call({
    ScheduleUpdateRequestDayOfWeekEnum? dayOfWeek,
    Time? startTime,
    Time? endTime,
    bool? isRecurring,
    DateTime? specificDate,
    bool? isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfScheduleUpdateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfScheduleUpdateRequest.copyWith.fieldName(...)`
class _$ScheduleUpdateRequestCWProxyImpl
    implements _$ScheduleUpdateRequestCWProxy {
  const _$ScheduleUpdateRequestCWProxyImpl(this._value);

  final ScheduleUpdateRequest _value;

  @override
  ScheduleUpdateRequest dayOfWeek(
    ScheduleUpdateRequestDayOfWeekEnum? dayOfWeek,
  ) => this(dayOfWeek: dayOfWeek);

  @override
  ScheduleUpdateRequest startTime(Time? startTime) =>
      this(startTime: startTime);

  @override
  ScheduleUpdateRequest endTime(Time? endTime) => this(endTime: endTime);

  @override
  ScheduleUpdateRequest isRecurring(bool? isRecurring) =>
      this(isRecurring: isRecurring);

  @override
  ScheduleUpdateRequest specificDate(DateTime? specificDate) =>
      this(specificDate: specificDate);

  @override
  ScheduleUpdateRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ScheduleUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ScheduleUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ScheduleUpdateRequest call({
    Object? dayOfWeek = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? isRecurring = const $CopyWithPlaceholder(),
    Object? specificDate = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return ScheduleUpdateRequest(
      dayOfWeek: dayOfWeek == const $CopyWithPlaceholder()
          ? _value.dayOfWeek
          // ignore: cast_nullable_to_non_nullable
          : dayOfWeek as ScheduleUpdateRequestDayOfWeekEnum?,
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

extension $ScheduleUpdateRequestCopyWith on ScheduleUpdateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfScheduleUpdateRequest.copyWith(...)` or like so:`instanceOfScheduleUpdateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ScheduleUpdateRequestCWProxy get copyWith =>
      _$ScheduleUpdateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleUpdateRequest _$ScheduleUpdateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ScheduleUpdateRequest', json, ($checkedConvert) {
  final val = ScheduleUpdateRequest(
    dayOfWeek: $checkedConvert(
      'dayOfWeek',
      (v) =>
          $enumDecodeNullable(_$ScheduleUpdateRequestDayOfWeekEnumEnumMap, v),
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

Map<String, dynamic> _$ScheduleUpdateRequestToJson(
  ScheduleUpdateRequest instance,
) => <String, dynamic>{
  'dayOfWeek': ?_$ScheduleUpdateRequestDayOfWeekEnumEnumMap[instance.dayOfWeek],
  'startTime': ?instance.startTime?.toJson(),
  'endTime': ?instance.endTime?.toJson(),
  'isRecurring': ?instance.isRecurring,
  'specificDate': ?instance.specificDate?.toIso8601String(),
  'isActive': ?instance.isActive,
};

const _$ScheduleUpdateRequestDayOfWeekEnumEnumMap = {
  ScheduleUpdateRequestDayOfWeekEnum.sunday: 'sunday',
  ScheduleUpdateRequestDayOfWeekEnum.monday: 'monday',
  ScheduleUpdateRequestDayOfWeekEnum.tuesday: 'tuesday',
  ScheduleUpdateRequestDayOfWeekEnum.wednesday: 'wednesday',
  ScheduleUpdateRequestDayOfWeekEnum.thursday: 'thursday',
  ScheduleUpdateRequestDayOfWeekEnum.friday: 'friday',
  ScheduleUpdateRequestDayOfWeekEnum.saturday: 'saturday',
};
