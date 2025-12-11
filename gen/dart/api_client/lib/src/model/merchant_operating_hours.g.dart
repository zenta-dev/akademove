// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_operating_hours.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantOperatingHoursCWProxy {
  MerchantOperatingHours id(String id);

  MerchantOperatingHours merchantId(String merchantId);

  MerchantOperatingHours dayOfWeek(DayOfWeek dayOfWeek);

  MerchantOperatingHours isOpen(bool isOpen);

  MerchantOperatingHours is24Hours(bool is24Hours);

  MerchantOperatingHours openTime(Time? openTime);

  MerchantOperatingHours closeTime(Time? closeTime);

  MerchantOperatingHours createdAt(DateTime createdAt);

  MerchantOperatingHours updatedAt(DateTime updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantOperatingHours(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantOperatingHours(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantOperatingHours call({
    String id,
    String merchantId,
    DayOfWeek dayOfWeek,
    bool isOpen,
    bool is24Hours,
    Time? openTime,
    Time? closeTime,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantOperatingHours.copyWith(...)` or call `instanceOfMerchantOperatingHours.copyWith.fieldName(value)` for a single field.
class _$MerchantOperatingHoursCWProxyImpl
    implements _$MerchantOperatingHoursCWProxy {
  const _$MerchantOperatingHoursCWProxyImpl(this._value);

  final MerchantOperatingHours _value;

  @override
  MerchantOperatingHours id(String id) => call(id: id);

  @override
  MerchantOperatingHours merchantId(String merchantId) =>
      call(merchantId: merchantId);

  @override
  MerchantOperatingHours dayOfWeek(DayOfWeek dayOfWeek) =>
      call(dayOfWeek: dayOfWeek);

  @override
  MerchantOperatingHours isOpen(bool isOpen) => call(isOpen: isOpen);

  @override
  MerchantOperatingHours is24Hours(bool is24Hours) =>
      call(is24Hours: is24Hours);

  @override
  MerchantOperatingHours openTime(Time? openTime) => call(openTime: openTime);

  @override
  MerchantOperatingHours closeTime(Time? closeTime) =>
      call(closeTime: closeTime);

  @override
  MerchantOperatingHours createdAt(DateTime createdAt) =>
      call(createdAt: createdAt);

  @override
  MerchantOperatingHours updatedAt(DateTime updatedAt) =>
      call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantOperatingHours(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantOperatingHours(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantOperatingHours call({
    Object? id = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? dayOfWeek = const $CopyWithPlaceholder(),
    Object? isOpen = const $CopyWithPlaceholder(),
    Object? is24Hours = const $CopyWithPlaceholder(),
    Object? openTime = const $CopyWithPlaceholder(),
    Object? closeTime = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return MerchantOperatingHours(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      merchantId:
          merchantId == const $CopyWithPlaceholder() || merchantId == null
          ? _value.merchantId
          // ignore: cast_nullable_to_non_nullable
          : merchantId as String,
      dayOfWeek: dayOfWeek == const $CopyWithPlaceholder() || dayOfWeek == null
          ? _value.dayOfWeek
          // ignore: cast_nullable_to_non_nullable
          : dayOfWeek as DayOfWeek,
      isOpen: isOpen == const $CopyWithPlaceholder() || isOpen == null
          ? _value.isOpen
          // ignore: cast_nullable_to_non_nullable
          : isOpen as bool,
      is24Hours: is24Hours == const $CopyWithPlaceholder() || is24Hours == null
          ? _value.is24Hours
          // ignore: cast_nullable_to_non_nullable
          : is24Hours as bool,
      openTime: openTime == const $CopyWithPlaceholder()
          ? _value.openTime
          // ignore: cast_nullable_to_non_nullable
          : openTime as Time?,
      closeTime: closeTime == const $CopyWithPlaceholder()
          ? _value.closeTime
          // ignore: cast_nullable_to_non_nullable
          : closeTime as Time?,
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

extension $MerchantOperatingHoursCopyWith on MerchantOperatingHours {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantOperatingHours.copyWith(...)` or `instanceOfMerchantOperatingHours.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantOperatingHoursCWProxy get copyWith =>
      _$MerchantOperatingHoursCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantOperatingHours _$MerchantOperatingHoursFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantOperatingHours', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'merchantId',
      'dayOfWeek',
      'isOpen',
      'is24Hours',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = MerchantOperatingHours(
    id: $checkedConvert('id', (v) => v as String),
    merchantId: $checkedConvert('merchantId', (v) => v as String),
    dayOfWeek: $checkedConvert(
      'dayOfWeek',
      (v) => $enumDecode(_$DayOfWeekEnumMap, v),
    ),
    isOpen: $checkedConvert('isOpen', (v) => v as bool),
    is24Hours: $checkedConvert('is24Hours', (v) => v as bool),
    openTime: $checkedConvert(
      'openTime',
      (v) => v == null ? null : Time.fromJson(v as Map<String, dynamic>),
    ),
    closeTime: $checkedConvert(
      'closeTime',
      (v) => v == null ? null : Time.fromJson(v as Map<String, dynamic>),
    ),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$MerchantOperatingHoursToJson(
  MerchantOperatingHours instance,
) => <String, dynamic>{
  'id': instance.id,
  'merchantId': instance.merchantId,
  'dayOfWeek': _$DayOfWeekEnumMap[instance.dayOfWeek]!,
  'isOpen': instance.isOpen,
  'is24Hours': instance.is24Hours,
  'openTime': ?instance.openTime?.toJson(),
  'closeTime': ?instance.closeTime?.toJson(),
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
