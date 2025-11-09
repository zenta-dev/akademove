// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_driver_schedule_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertDriverScheduleRequestCWProxy {
  InsertDriverScheduleRequest name(String name);

  InsertDriverScheduleRequest driverId(String driverId);

  InsertDriverScheduleRequest dayOfWeek(DayOfWeek dayOfWeek);

  InsertDriverScheduleRequest startTime(Time startTime);

  InsertDriverScheduleRequest endTime(Time endTime);

  InsertDriverScheduleRequest isRecurring(bool? isRecurring);

  InsertDriverScheduleRequest specificDate(DateTime? specificDate);

  InsertDriverScheduleRequest isActive(bool? isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertDriverScheduleRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertDriverScheduleRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertDriverScheduleRequest call({
    String name,
    String driverId,
    DayOfWeek dayOfWeek,
    Time startTime,
    Time endTime,
    bool? isRecurring,
    DateTime? specificDate,
    bool? isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsertDriverScheduleRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsertDriverScheduleRequest.copyWith.fieldName(...)`
class _$InsertDriverScheduleRequestCWProxyImpl
    implements _$InsertDriverScheduleRequestCWProxy {
  const _$InsertDriverScheduleRequestCWProxyImpl(this._value);

  final InsertDriverScheduleRequest _value;

  @override
  InsertDriverScheduleRequest name(String name) => this(name: name);

  @override
  InsertDriverScheduleRequest driverId(String driverId) =>
      this(driverId: driverId);

  @override
  InsertDriverScheduleRequest dayOfWeek(DayOfWeek dayOfWeek) =>
      this(dayOfWeek: dayOfWeek);

  @override
  InsertDriverScheduleRequest startTime(Time startTime) =>
      this(startTime: startTime);

  @override
  InsertDriverScheduleRequest endTime(Time endTime) => this(endTime: endTime);

  @override
  InsertDriverScheduleRequest isRecurring(bool? isRecurring) =>
      this(isRecurring: isRecurring);

  @override
  InsertDriverScheduleRequest specificDate(DateTime? specificDate) =>
      this(specificDate: specificDate);

  @override
  InsertDriverScheduleRequest isActive(bool? isActive) =>
      this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertDriverScheduleRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertDriverScheduleRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertDriverScheduleRequest call({
    Object? name = const $CopyWithPlaceholder(),
    Object? driverId = const $CopyWithPlaceholder(),
    Object? dayOfWeek = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? isRecurring = const $CopyWithPlaceholder(),
    Object? specificDate = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return InsertDriverScheduleRequest(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      driverId: driverId == const $CopyWithPlaceholder()
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String,
      dayOfWeek: dayOfWeek == const $CopyWithPlaceholder()
          ? _value.dayOfWeek
          // ignore: cast_nullable_to_non_nullable
          : dayOfWeek as DayOfWeek,
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

extension $InsertDriverScheduleRequestCopyWith on InsertDriverScheduleRequest {
  /// Returns a callable class that can be used as follows: `instanceOfInsertDriverScheduleRequest.copyWith(...)` or like so:`instanceOfInsertDriverScheduleRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertDriverScheduleRequestCWProxy get copyWith =>
      _$InsertDriverScheduleRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertDriverScheduleRequest _$InsertDriverScheduleRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('InsertDriverScheduleRequest', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'name',
      'driverId',
      'dayOfWeek',
      'startTime',
      'endTime',
    ],
  );
  final val = InsertDriverScheduleRequest(
    name: $checkedConvert('name', (v) => v as String),
    driverId: $checkedConvert('driverId', (v) => v as String),
    dayOfWeek: $checkedConvert(
      'dayOfWeek',
      (v) => $enumDecode(_$DayOfWeekEnumMap, v),
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

Map<String, dynamic> _$InsertDriverScheduleRequestToJson(
  InsertDriverScheduleRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'driverId': instance.driverId,
  'dayOfWeek': _$DayOfWeekEnumMap[instance.dayOfWeek]!,
  'startTime': instance.startTime.toJson(),
  'endTime': instance.endTime.toJson(),
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
