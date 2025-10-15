// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_create_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ScheduleCreateRequestCWProxy {
  ScheduleCreateRequest driverId(String driverId);

  ScheduleCreateRequest dayOfWeek(ScheduleCreateRequestDayOfWeekEnum dayOfWeek);

  ScheduleCreateRequest startTime(Time startTime);

  ScheduleCreateRequest endTime(Time endTime);

  ScheduleCreateRequest isRecurring(bool? isRecurring);

  ScheduleCreateRequest specificDate(DateTime? specificDate);

  ScheduleCreateRequest isActive(bool? isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ScheduleCreateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ScheduleCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ScheduleCreateRequest call({
    String driverId,
    ScheduleCreateRequestDayOfWeekEnum dayOfWeek,
    Time startTime,
    Time endTime,
    bool? isRecurring,
    DateTime? specificDate,
    bool? isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfScheduleCreateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfScheduleCreateRequest.copyWith.fieldName(...)`
class _$ScheduleCreateRequestCWProxyImpl
    implements _$ScheduleCreateRequestCWProxy {
  const _$ScheduleCreateRequestCWProxyImpl(this._value);

  final ScheduleCreateRequest _value;

  @override
  ScheduleCreateRequest driverId(String driverId) => this(driverId: driverId);

  @override
  ScheduleCreateRequest dayOfWeek(
    ScheduleCreateRequestDayOfWeekEnum dayOfWeek,
  ) => this(dayOfWeek: dayOfWeek);

  @override
  ScheduleCreateRequest startTime(Time startTime) => this(startTime: startTime);

  @override
  ScheduleCreateRequest endTime(Time endTime) => this(endTime: endTime);

  @override
  ScheduleCreateRequest isRecurring(bool? isRecurring) =>
      this(isRecurring: isRecurring);

  @override
  ScheduleCreateRequest specificDate(DateTime? specificDate) =>
      this(specificDate: specificDate);

  @override
  ScheduleCreateRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ScheduleCreateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ScheduleCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ScheduleCreateRequest call({
    Object? driverId = const $CopyWithPlaceholder(),
    Object? dayOfWeek = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? isRecurring = const $CopyWithPlaceholder(),
    Object? specificDate = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return ScheduleCreateRequest(
      driverId: driverId == const $CopyWithPlaceholder()
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String,
      dayOfWeek: dayOfWeek == const $CopyWithPlaceholder()
          ? _value.dayOfWeek
          // ignore: cast_nullable_to_non_nullable
          : dayOfWeek as ScheduleCreateRequestDayOfWeekEnum,
      startTime: startTime == const $CopyWithPlaceholder()
          ? _value.startTime
          // ignore: cast_nullable_to_non_nullable
          : startTime as Time,
      endTime: endTime == const $CopyWithPlaceholder()
          ? _value.endTime
          // ignore: cast_nullable_to_non_nullable
          : endTime as Time,
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

extension $ScheduleCreateRequestCopyWith on ScheduleCreateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfScheduleCreateRequest.copyWith(...)` or like so:`instanceOfScheduleCreateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ScheduleCreateRequestCWProxy get copyWith =>
      _$ScheduleCreateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleCreateRequest _$ScheduleCreateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ScheduleCreateRequest', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['driverId', 'dayOfWeek', 'startTime', 'endTime'],
  );
  final val = ScheduleCreateRequest(
    driverId: $checkedConvert('driverId', (v) => v as String),
    dayOfWeek: $checkedConvert(
      'dayOfWeek',
      (v) => $enumDecode(_$ScheduleCreateRequestDayOfWeekEnumEnumMap, v),
    ),
    startTime: $checkedConvert(
      'startTime',
      (v) => Time.fromJson(v as Map<String, dynamic>),
    ),
    endTime: $checkedConvert(
      'endTime',
      (v) => Time.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$ScheduleCreateRequestToJson(
  ScheduleCreateRequest instance,
) => <String, dynamic>{
  'driverId': instance.driverId,
  'dayOfWeek': _$ScheduleCreateRequestDayOfWeekEnumEnumMap[instance.dayOfWeek]!,
  'startTime': instance.startTime.toJson(),
  'endTime': instance.endTime.toJson(),
  'isRecurring': ?instance.isRecurring,
  'specificDate': ?instance.specificDate?.toIso8601String(),
  'isActive': ?instance.isActive,
};

const _$ScheduleCreateRequestDayOfWeekEnumEnumMap = {
  ScheduleCreateRequestDayOfWeekEnum.sunday: 'sunday',
  ScheduleCreateRequestDayOfWeekEnum.monday: 'monday',
  ScheduleCreateRequestDayOfWeekEnum.tuesday: 'tuesday',
  ScheduleCreateRequestDayOfWeekEnum.wednesday: 'wednesday',
  ScheduleCreateRequestDayOfWeekEnum.thursday: 'thursday',
  ScheduleCreateRequestDayOfWeekEnum.friday: 'friday',
  ScheduleCreateRequestDayOfWeekEnum.saturday: 'saturday',
};
