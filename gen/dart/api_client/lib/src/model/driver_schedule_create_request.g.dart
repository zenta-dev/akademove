// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_schedule_create_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverScheduleCreateRequestCWProxy {
  DriverScheduleCreateRequest name(String? name);

  DriverScheduleCreateRequest driverId(String? driverId);

  DriverScheduleCreateRequest dayOfWeek(DayOfWeek dayOfWeek);

  DriverScheduleCreateRequest startTime(Time startTime);

  DriverScheduleCreateRequest endTime(Time endTime);

  DriverScheduleCreateRequest isRecurring(bool? isRecurring);

  DriverScheduleCreateRequest specificDate(DateTime? specificDate);

  DriverScheduleCreateRequest isActive(bool? isActive);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverScheduleCreateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverScheduleCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverScheduleCreateRequest call({
    String? name,
    String? driverId,
    DayOfWeek dayOfWeek,
    Time startTime,
    Time endTime,
    bool? isRecurring,
    DateTime? specificDate,
    bool? isActive,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverScheduleCreateRequest.copyWith(...)` or call `instanceOfDriverScheduleCreateRequest.copyWith.fieldName(value)` for a single field.
class _$DriverScheduleCreateRequestCWProxyImpl
    implements _$DriverScheduleCreateRequestCWProxy {
  const _$DriverScheduleCreateRequestCWProxyImpl(this._value);

  final DriverScheduleCreateRequest _value;

  @override
  DriverScheduleCreateRequest name(String? name) => call(name: name);

  @override
  DriverScheduleCreateRequest driverId(String? driverId) =>
      call(driverId: driverId);

  @override
  DriverScheduleCreateRequest dayOfWeek(DayOfWeek dayOfWeek) =>
      call(dayOfWeek: dayOfWeek);

  @override
  DriverScheduleCreateRequest startTime(Time startTime) =>
      call(startTime: startTime);

  @override
  DriverScheduleCreateRequest endTime(Time endTime) => call(endTime: endTime);

  @override
  DriverScheduleCreateRequest isRecurring(bool? isRecurring) =>
      call(isRecurring: isRecurring);

  @override
  DriverScheduleCreateRequest specificDate(DateTime? specificDate) =>
      call(specificDate: specificDate);

  @override
  DriverScheduleCreateRequest isActive(bool? isActive) =>
      call(isActive: isActive);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverScheduleCreateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverScheduleCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverScheduleCreateRequest call({
    Object? name = const $CopyWithPlaceholder(),
    Object? driverId = const $CopyWithPlaceholder(),
    Object? dayOfWeek = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? isRecurring = const $CopyWithPlaceholder(),
    Object? specificDate = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return DriverScheduleCreateRequest(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      driverId: driverId == const $CopyWithPlaceholder()
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String?,
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
    );
  }
}

extension $DriverScheduleCreateRequestCopyWith on DriverScheduleCreateRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverScheduleCreateRequest.copyWith(...)` or `instanceOfDriverScheduleCreateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverScheduleCreateRequestCWProxy get copyWith =>
      _$DriverScheduleCreateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverScheduleCreateRequest _$DriverScheduleCreateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverScheduleCreateRequest', json, ($checkedConvert) {
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
  final val = DriverScheduleCreateRequest(
    name: $checkedConvert('name', (v) => v as String?),
    driverId: $checkedConvert('driverId', (v) => v as String?),
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

Map<String, dynamic> _$DriverScheduleCreateRequestToJson(
  DriverScheduleCreateRequest instance,
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
  DayOfWeek.SUNDAY: 'SUNDAY',
  DayOfWeek.MONDAY: 'MONDAY',
  DayOfWeek.TUESDAY: 'TUESDAY',
  DayOfWeek.WEDNESDAY: 'WEDNESDAY',
  DayOfWeek.THURSDAY: 'THURSDAY',
  DayOfWeek.FRIDAY: 'FRIDAY',
  DayOfWeek.SATURDAY: 'SATURDAY',
};
