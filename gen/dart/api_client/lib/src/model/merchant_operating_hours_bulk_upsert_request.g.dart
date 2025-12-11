// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_operating_hours_bulk_upsert_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantOperatingHoursBulkUpsertRequestCWProxy {
  MerchantOperatingHoursBulkUpsertRequest hours(
    List<MerchantOperatingHoursCreateRequest> hours,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantOperatingHoursBulkUpsertRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantOperatingHoursBulkUpsertRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantOperatingHoursBulkUpsertRequest call({
    List<MerchantOperatingHoursCreateRequest> hours,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantOperatingHoursBulkUpsertRequest.copyWith(...)` or call `instanceOfMerchantOperatingHoursBulkUpsertRequest.copyWith.fieldName(value)` for a single field.
class _$MerchantOperatingHoursBulkUpsertRequestCWProxyImpl
    implements _$MerchantOperatingHoursBulkUpsertRequestCWProxy {
  const _$MerchantOperatingHoursBulkUpsertRequestCWProxyImpl(this._value);

  final MerchantOperatingHoursBulkUpsertRequest _value;

  @override
  MerchantOperatingHoursBulkUpsertRequest hours(
    List<MerchantOperatingHoursCreateRequest> hours,
  ) => call(hours: hours);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantOperatingHoursBulkUpsertRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantOperatingHoursBulkUpsertRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantOperatingHoursBulkUpsertRequest call({
    Object? hours = const $CopyWithPlaceholder(),
  }) {
    return MerchantOperatingHoursBulkUpsertRequest(
      hours: hours == const $CopyWithPlaceholder() || hours == null
          ? _value.hours
          // ignore: cast_nullable_to_non_nullable
          : hours as List<MerchantOperatingHoursCreateRequest>,
    );
  }
}

extension $MerchantOperatingHoursBulkUpsertRequestCopyWith
    on MerchantOperatingHoursBulkUpsertRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantOperatingHoursBulkUpsertRequest.copyWith(...)` or `instanceOfMerchantOperatingHoursBulkUpsertRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantOperatingHoursBulkUpsertRequestCWProxy get copyWith =>
      _$MerchantOperatingHoursBulkUpsertRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantOperatingHoursBulkUpsertRequest
_$MerchantOperatingHoursBulkUpsertRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MerchantOperatingHoursBulkUpsertRequest', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['hours']);
      final val = MerchantOperatingHoursBulkUpsertRequest(
        hours: $checkedConvert(
          'hours',
          (v) => (v as List<dynamic>)
              .map(
                (e) => MerchantOperatingHoursCreateRequest.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MerchantOperatingHoursBulkUpsertRequestToJson(
  MerchantOperatingHoursBulkUpsertRequest instance,
) => <String, dynamic>{'hours': instance.hours.map((e) => e.toJson()).toList()};
