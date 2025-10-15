// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ScheduleCWProxy {
  Schedule id(String id);

  Schedule driverId(String driverId);

  Schedule dayOfWeek(ScheduleDayOfWeekEnum dayOfWeek);

  Schedule startTime(Time startTime);

  Schedule endTime(Time endTime);

  Schedule isRecurring(bool? isRecurring);

  Schedule specificDate(DateTime? specificDate);

  Schedule isActive(bool? isActive);

  Schedule createdAt(DateTime createdAt);

  Schedule updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Schedule(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Schedule(...).copyWith(id: 12, name: "My name")
  /// ````
  Schedule call({
    String id,
    String driverId,
    ScheduleDayOfWeekEnum dayOfWeek,
    Time startTime,
    Time endTime,
    bool? isRecurring,
    DateTime? specificDate,
    bool? isActive,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSchedule.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSchedule.copyWith.fieldName(...)`
class _$ScheduleCWProxyImpl implements _$ScheduleCWProxy {
  const _$ScheduleCWProxyImpl(this._value);

  final Schedule _value;

  @override
  Schedule id(String id) => this(id: id);

  @override
  Schedule driverId(String driverId) => this(driverId: driverId);

  @override
  Schedule dayOfWeek(ScheduleDayOfWeekEnum dayOfWeek) =>
      this(dayOfWeek: dayOfWeek);

  @override
  Schedule startTime(Time startTime) => this(startTime: startTime);

  @override
  Schedule endTime(Time endTime) => this(endTime: endTime);

  @override
  Schedule isRecurring(bool? isRecurring) => this(isRecurring: isRecurring);

  @override
  Schedule specificDate(DateTime? specificDate) =>
      this(specificDate: specificDate);

  @override
  Schedule isActive(bool? isActive) => this(isActive: isActive);

  @override
  Schedule createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Schedule updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Schedule(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Schedule(...).copyWith(id: 12, name: "My name")
  /// ````
  Schedule call({
    Object? id = const $CopyWithPlaceholder(),
    Object? driverId = const $CopyWithPlaceholder(),
    Object? dayOfWeek = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? isRecurring = const $CopyWithPlaceholder(),
    Object? specificDate = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Schedule(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      driverId: driverId == const $CopyWithPlaceholder()
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String,
      dayOfWeek: dayOfWeek == const $CopyWithPlaceholder()
          ? _value.dayOfWeek
          // ignore: cast_nullable_to_non_nullable
          : dayOfWeek as ScheduleDayOfWeekEnum,
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
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $ScheduleCopyWith on Schedule {
  /// Returns a callable class that can be used as follows: `instanceOfSchedule.copyWith(...)` or like so:`instanceOfSchedule.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ScheduleCWProxy get copyWith => _$ScheduleCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('Schedule', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'driverId',
      'dayOfWeek',
      'startTime',
      'endTime',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = Schedule(
    id: $checkedConvert('id', (v) => v as String),
    driverId: $checkedConvert('driverId', (v) => v as String),
    dayOfWeek: $checkedConvert(
      'dayOfWeek',
      (v) => $enumDecode(_$ScheduleDayOfWeekEnumEnumMap, v),
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
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
  'id': instance.id,
  'driverId': instance.driverId,
  'dayOfWeek': _$ScheduleDayOfWeekEnumEnumMap[instance.dayOfWeek]!,
  'startTime': instance.startTime.toJson(),
  'endTime': instance.endTime.toJson(),
  'isRecurring': ?instance.isRecurring,
  'specificDate': ?instance.specificDate?.toIso8601String(),
  'isActive': ?instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$ScheduleDayOfWeekEnumEnumMap = {
  ScheduleDayOfWeekEnum.sunday: 'sunday',
  ScheduleDayOfWeekEnum.monday: 'monday',
  ScheduleDayOfWeekEnum.tuesday: 'tuesday',
  ScheduleDayOfWeekEnum.wednesday: 'wednesday',
  ScheduleDayOfWeekEnum.thursday: 'thursday',
  ScheduleDayOfWeekEnum.friday: 'friday',
  ScheduleDayOfWeekEnum.saturday: 'saturday',
};
