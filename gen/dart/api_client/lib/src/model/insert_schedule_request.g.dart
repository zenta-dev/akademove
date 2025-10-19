// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_schedule_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertScheduleRequestCWProxy {
  InsertScheduleRequest driverId(String driverId);

  InsertScheduleRequest dayOfWeek(InsertScheduleRequestDayOfWeekEnum dayOfWeek);

  InsertScheduleRequest startTime(Time startTime);

  InsertScheduleRequest endTime(Time endTime);

  InsertScheduleRequest isRecurring(bool? isRecurring);

  InsertScheduleRequest specificDate(DateTime? specificDate);

  InsertScheduleRequest isActive(bool? isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertScheduleRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertScheduleRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertScheduleRequest call({
    String driverId,
    InsertScheduleRequestDayOfWeekEnum dayOfWeek,
    Time startTime,
    Time endTime,
    bool? isRecurring,
    DateTime? specificDate,
    bool? isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsertScheduleRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsertScheduleRequest.copyWith.fieldName(...)`
class _$InsertScheduleRequestCWProxyImpl
    implements _$InsertScheduleRequestCWProxy {
  const _$InsertScheduleRequestCWProxyImpl(this._value);

  final InsertScheduleRequest _value;

  @override
  InsertScheduleRequest driverId(String driverId) => this(driverId: driverId);

  @override
  InsertScheduleRequest dayOfWeek(
    InsertScheduleRequestDayOfWeekEnum dayOfWeek,
  ) => this(dayOfWeek: dayOfWeek);

  @override
  InsertScheduleRequest startTime(Time startTime) => this(startTime: startTime);

  @override
  InsertScheduleRequest endTime(Time endTime) => this(endTime: endTime);

  @override
  InsertScheduleRequest isRecurring(bool? isRecurring) =>
      this(isRecurring: isRecurring);

  @override
  InsertScheduleRequest specificDate(DateTime? specificDate) =>
      this(specificDate: specificDate);

  @override
  InsertScheduleRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertScheduleRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertScheduleRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertScheduleRequest call({
    Object? driverId = const $CopyWithPlaceholder(),
    Object? dayOfWeek = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? isRecurring = const $CopyWithPlaceholder(),
    Object? specificDate = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return InsertScheduleRequest(
      driverId: driverId == const $CopyWithPlaceholder()
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String,
      dayOfWeek: dayOfWeek == const $CopyWithPlaceholder()
          ? _value.dayOfWeek
          // ignore: cast_nullable_to_non_nullable
          : dayOfWeek as InsertScheduleRequestDayOfWeekEnum,
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

extension $InsertScheduleRequestCopyWith on InsertScheduleRequest {
  /// Returns a callable class that can be used as follows: `instanceOfInsertScheduleRequest.copyWith(...)` or like so:`instanceOfInsertScheduleRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertScheduleRequestCWProxy get copyWith =>
      _$InsertScheduleRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertScheduleRequest _$InsertScheduleRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('InsertScheduleRequest', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['driverId', 'dayOfWeek', 'startTime', 'endTime'],
  );
  final val = InsertScheduleRequest(
    driverId: $checkedConvert('driverId', (v) => v as String),
    dayOfWeek: $checkedConvert(
      'dayOfWeek',
      (v) => $enumDecode(_$InsertScheduleRequestDayOfWeekEnumEnumMap, v),
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

Map<String, dynamic> _$InsertScheduleRequestToJson(
  InsertScheduleRequest instance,
) => <String, dynamic>{
  'driverId': instance.driverId,
  'dayOfWeek': _$InsertScheduleRequestDayOfWeekEnumEnumMap[instance.dayOfWeek]!,
  'startTime': instance.startTime.toJson(),
  'endTime': instance.endTime.toJson(),
  'isRecurring': ?instance.isRecurring,
  'specificDate': ?instance.specificDate?.toIso8601String(),
  'isActive': ?instance.isActive,
};

const _$InsertScheduleRequestDayOfWeekEnumEnumMap = {
  InsertScheduleRequestDayOfWeekEnum.sunday: 'sunday',
  InsertScheduleRequestDayOfWeekEnum.monday: 'monday',
  InsertScheduleRequestDayOfWeekEnum.tuesday: 'tuesday',
  InsertScheduleRequestDayOfWeekEnum.wednesday: 'wednesday',
  InsertScheduleRequestDayOfWeekEnum.thursday: 'thursday',
  InsertScheduleRequestDayOfWeekEnum.friday: 'friday',
  InsertScheduleRequestDayOfWeekEnum.saturday: 'saturday',
};
