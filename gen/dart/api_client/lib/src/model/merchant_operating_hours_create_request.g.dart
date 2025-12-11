// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_operating_hours_create_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantOperatingHoursCreateRequestCWProxy {
  MerchantOperatingHoursCreateRequest dayOfWeek(DayOfWeek dayOfWeek);

  MerchantOperatingHoursCreateRequest isOpen(bool isOpen);

  MerchantOperatingHoursCreateRequest is24Hours(bool is24Hours);

  MerchantOperatingHoursCreateRequest openTime(Time? openTime);

  MerchantOperatingHoursCreateRequest closeTime(Time? closeTime);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantOperatingHoursCreateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantOperatingHoursCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantOperatingHoursCreateRequest call({
    DayOfWeek dayOfWeek,
    bool isOpen,
    bool is24Hours,
    Time? openTime,
    Time? closeTime,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantOperatingHoursCreateRequest.copyWith(...)` or call `instanceOfMerchantOperatingHoursCreateRequest.copyWith.fieldName(value)` for a single field.
class _$MerchantOperatingHoursCreateRequestCWProxyImpl
    implements _$MerchantOperatingHoursCreateRequestCWProxy {
  const _$MerchantOperatingHoursCreateRequestCWProxyImpl(this._value);

  final MerchantOperatingHoursCreateRequest _value;

  @override
  MerchantOperatingHoursCreateRequest dayOfWeek(DayOfWeek dayOfWeek) =>
      call(dayOfWeek: dayOfWeek);

  @override
  MerchantOperatingHoursCreateRequest isOpen(bool isOpen) =>
      call(isOpen: isOpen);

  @override
  MerchantOperatingHoursCreateRequest is24Hours(bool is24Hours) =>
      call(is24Hours: is24Hours);

  @override
  MerchantOperatingHoursCreateRequest openTime(Time? openTime) =>
      call(openTime: openTime);

  @override
  MerchantOperatingHoursCreateRequest closeTime(Time? closeTime) =>
      call(closeTime: closeTime);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantOperatingHoursCreateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantOperatingHoursCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantOperatingHoursCreateRequest call({
    Object? dayOfWeek = const $CopyWithPlaceholder(),
    Object? isOpen = const $CopyWithPlaceholder(),
    Object? is24Hours = const $CopyWithPlaceholder(),
    Object? openTime = const $CopyWithPlaceholder(),
    Object? closeTime = const $CopyWithPlaceholder(),
  }) {
    return MerchantOperatingHoursCreateRequest(
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
    );
  }
}

extension $MerchantOperatingHoursCreateRequestCopyWith
    on MerchantOperatingHoursCreateRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantOperatingHoursCreateRequest.copyWith(...)` or `instanceOfMerchantOperatingHoursCreateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantOperatingHoursCreateRequestCWProxy get copyWith =>
      _$MerchantOperatingHoursCreateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantOperatingHoursCreateRequest
_$MerchantOperatingHoursCreateRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MerchantOperatingHoursCreateRequest', json, (
      $checkedConvert,
    ) {
      $checkKeys(
        json,
        requiredKeys: const ['dayOfWeek', 'isOpen', 'is24Hours'],
      );
      final val = MerchantOperatingHoursCreateRequest(
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
      );
      return val;
    });

Map<String, dynamic> _$MerchantOperatingHoursCreateRequestToJson(
  MerchantOperatingHoursCreateRequest instance,
) => <String, dynamic>{
  'dayOfWeek': _$DayOfWeekEnumMap[instance.dayOfWeek]!,
  'isOpen': instance.isOpen,
  'is24Hours': instance.is24Hours,
  'openTime': ?instance.openTime?.toJson(),
  'closeTime': ?instance.closeTime?.toJson(),
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
