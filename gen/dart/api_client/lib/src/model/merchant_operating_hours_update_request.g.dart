// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_operating_hours_update_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantOperatingHoursUpdateRequestCWProxy {
  MerchantOperatingHoursUpdateRequest dayOfWeek(DayOfWeek? dayOfWeek);

  MerchantOperatingHoursUpdateRequest isOpen(bool? isOpen);

  MerchantOperatingHoursUpdateRequest is24Hours(bool? is24Hours);

  MerchantOperatingHoursUpdateRequest openTime(Time? openTime);

  MerchantOperatingHoursUpdateRequest closeTime(Time? closeTime);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantOperatingHoursUpdateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantOperatingHoursUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantOperatingHoursUpdateRequest call({
    DayOfWeek? dayOfWeek,
    bool? isOpen,
    bool? is24Hours,
    Time? openTime,
    Time? closeTime,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantOperatingHoursUpdateRequest.copyWith(...)` or call `instanceOfMerchantOperatingHoursUpdateRequest.copyWith.fieldName(value)` for a single field.
class _$MerchantOperatingHoursUpdateRequestCWProxyImpl
    implements _$MerchantOperatingHoursUpdateRequestCWProxy {
  const _$MerchantOperatingHoursUpdateRequestCWProxyImpl(this._value);

  final MerchantOperatingHoursUpdateRequest _value;

  @override
  MerchantOperatingHoursUpdateRequest dayOfWeek(DayOfWeek? dayOfWeek) =>
      call(dayOfWeek: dayOfWeek);

  @override
  MerchantOperatingHoursUpdateRequest isOpen(bool? isOpen) =>
      call(isOpen: isOpen);

  @override
  MerchantOperatingHoursUpdateRequest is24Hours(bool? is24Hours) =>
      call(is24Hours: is24Hours);

  @override
  MerchantOperatingHoursUpdateRequest openTime(Time? openTime) =>
      call(openTime: openTime);

  @override
  MerchantOperatingHoursUpdateRequest closeTime(Time? closeTime) =>
      call(closeTime: closeTime);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantOperatingHoursUpdateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantOperatingHoursUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantOperatingHoursUpdateRequest call({
    Object? dayOfWeek = const $CopyWithPlaceholder(),
    Object? isOpen = const $CopyWithPlaceholder(),
    Object? is24Hours = const $CopyWithPlaceholder(),
    Object? openTime = const $CopyWithPlaceholder(),
    Object? closeTime = const $CopyWithPlaceholder(),
  }) {
    return MerchantOperatingHoursUpdateRequest(
      dayOfWeek: dayOfWeek == const $CopyWithPlaceholder()
          ? _value.dayOfWeek
          // ignore: cast_nullable_to_non_nullable
          : dayOfWeek as DayOfWeek?,
      isOpen: isOpen == const $CopyWithPlaceholder()
          ? _value.isOpen
          // ignore: cast_nullable_to_non_nullable
          : isOpen as bool?,
      is24Hours: is24Hours == const $CopyWithPlaceholder()
          ? _value.is24Hours
          // ignore: cast_nullable_to_non_nullable
          : is24Hours as bool?,
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

extension $MerchantOperatingHoursUpdateRequestCopyWith
    on MerchantOperatingHoursUpdateRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantOperatingHoursUpdateRequest.copyWith(...)` or `instanceOfMerchantOperatingHoursUpdateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantOperatingHoursUpdateRequestCWProxy get copyWith =>
      _$MerchantOperatingHoursUpdateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantOperatingHoursUpdateRequest
_$MerchantOperatingHoursUpdateRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MerchantOperatingHoursUpdateRequest', json, (
      $checkedConvert,
    ) {
      final val = MerchantOperatingHoursUpdateRequest(
        dayOfWeek: $checkedConvert(
          'dayOfWeek',
          (v) => $enumDecodeNullable(_$DayOfWeekEnumMap, v),
        ),
        isOpen: $checkedConvert('isOpen', (v) => v as bool?),
        is24Hours: $checkedConvert('is24Hours', (v) => v as bool?),
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

Map<String, dynamic> _$MerchantOperatingHoursUpdateRequestToJson(
  MerchantOperatingHoursUpdateRequest instance,
) => <String, dynamic>{
  'dayOfWeek': ?_$DayOfWeekEnumMap[instance.dayOfWeek],
  'isOpen': ?instance.isOpen,
  'is24Hours': ?instance.is24Hours,
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
