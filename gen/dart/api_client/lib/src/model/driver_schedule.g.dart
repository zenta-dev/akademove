// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_schedule.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverScheduleCWProxy {
  DriverSchedule id(String id);

  DriverSchedule name(String name);

  DriverSchedule driverId(String driverId);

  DriverSchedule dayOfWeek(DayOfWeek dayOfWeek);

  DriverSchedule startTime(Time startTime);

  DriverSchedule endTime(Time endTime);

  DriverSchedule isRecurring(bool? isRecurring);

  DriverSchedule specificDate(DateTime? specificDate);

  DriverSchedule isActive(bool? isActive);

  DriverSchedule createdAt(DateTime createdAt);

  DriverSchedule updatedAt(DateTime updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverSchedule(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverSchedule(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverSchedule call({
    String id,
    String name,
    String driverId,
    DayOfWeek dayOfWeek,
    Time startTime,
    Time endTime,
    bool? isRecurring,
    DateTime? specificDate,
    bool? isActive,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverSchedule.copyWith(...)` or call `instanceOfDriverSchedule.copyWith.fieldName(value)` for a single field.
class _$DriverScheduleCWProxyImpl implements _$DriverScheduleCWProxy {
  const _$DriverScheduleCWProxyImpl(this._value);

  final DriverSchedule _value;

  @override
  DriverSchedule id(String id) => call(id: id);

  @override
  DriverSchedule name(String name) => call(name: name);

  @override
  DriverSchedule driverId(String driverId) => call(driverId: driverId);

  @override
  DriverSchedule dayOfWeek(DayOfWeek dayOfWeek) => call(dayOfWeek: dayOfWeek);

  @override
  DriverSchedule startTime(Time startTime) => call(startTime: startTime);

  @override
  DriverSchedule endTime(Time endTime) => call(endTime: endTime);

  @override
  DriverSchedule isRecurring(bool? isRecurring) =>
      call(isRecurring: isRecurring);

  @override
  DriverSchedule specificDate(DateTime? specificDate) =>
      call(specificDate: specificDate);

  @override
  DriverSchedule isActive(bool? isActive) => call(isActive: isActive);

  @override
  DriverSchedule createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  DriverSchedule updatedAt(DateTime updatedAt) => call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverSchedule(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverSchedule(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverSchedule call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
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
    return DriverSchedule(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      driverId: driverId == const $CopyWithPlaceholder() || driverId == null
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String,
      dayOfWeek: dayOfWeek == const $CopyWithPlaceholder() || dayOfWeek == null
          ? _value.dayOfWeek
          // ignore: cast_nullable_to_non_nullable
          : dayOfWeek as DayOfWeek,
      startTime: startTime == const $CopyWithPlaceholder() || startTime == null
          ? _value.startTime
          // ignore: cast_nullable_to_non_nullable
          : startTime as Time,
      endTime: endTime == const $CopyWithPlaceholder() || endTime == null
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
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $DriverScheduleCopyWith on DriverSchedule {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverSchedule.copyWith(...)` or `instanceOfDriverSchedule.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverScheduleCWProxy get copyWith => _$DriverScheduleCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverSchedule _$DriverScheduleFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverSchedule', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'driverId',
      'dayOfWeek',
      'startTime',
      'endTime',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = DriverSchedule(
    id: $checkedConvert('id', (v) => v as String),
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
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$DriverScheduleToJson(DriverSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'driverId': instance.driverId,
      'dayOfWeek': _$DayOfWeekEnumMap[instance.dayOfWeek]!,
      'startTime': instance.startTime.toJson(),
      'endTime': instance.endTime.toJson(),
      'isRecurring': ?instance.isRecurring,
      'specificDate': ?instance.specificDate?.toIso8601String(),
      'isActive': ?instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
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
