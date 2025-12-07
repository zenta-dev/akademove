// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_get_availability_status200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantGetAvailabilityStatus200ResponseCWProxy {
  MerchantGetAvailabilityStatus200Response message(String message);

  MerchantGetAvailabilityStatus200Response data(
    MerchantGetAvailabilityStatus200ResponseData data,
  );

  MerchantGetAvailabilityStatus200Response pagination(
    PaginationResult? pagination,
  );

  MerchantGetAvailabilityStatus200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantGetAvailabilityStatus200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantGetAvailabilityStatus200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantGetAvailabilityStatus200Response call({
    String message,
    MerchantGetAvailabilityStatus200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantGetAvailabilityStatus200Response.copyWith(...)` or call `instanceOfMerchantGetAvailabilityStatus200Response.copyWith.fieldName(value)` for a single field.
class _$MerchantGetAvailabilityStatus200ResponseCWProxyImpl
    implements _$MerchantGetAvailabilityStatus200ResponseCWProxy {
  const _$MerchantGetAvailabilityStatus200ResponseCWProxyImpl(this._value);

  final MerchantGetAvailabilityStatus200Response _value;

  @override
  MerchantGetAvailabilityStatus200Response message(String message) =>
      call(message: message);

  @override
  MerchantGetAvailabilityStatus200Response data(
    MerchantGetAvailabilityStatus200ResponseData data,
  ) => call(data: data);

  @override
  MerchantGetAvailabilityStatus200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  MerchantGetAvailabilityStatus200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantGetAvailabilityStatus200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantGetAvailabilityStatus200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantGetAvailabilityStatus200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantGetAvailabilityStatus200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as MerchantGetAvailabilityStatus200ResponseData,
      pagination: pagination == const $CopyWithPlaceholder()
          ? _value.pagination
          // ignore: cast_nullable_to_non_nullable
          : pagination as PaginationResult?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $MerchantGetAvailabilityStatus200ResponseCopyWith
    on MerchantGetAvailabilityStatus200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantGetAvailabilityStatus200Response.copyWith(...)` or `instanceOfMerchantGetAvailabilityStatus200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantGetAvailabilityStatus200ResponseCWProxy get copyWith =>
      _$MerchantGetAvailabilityStatus200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantGetAvailabilityStatus200Response
_$MerchantGetAvailabilityStatus200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MerchantGetAvailabilityStatus200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = MerchantGetAvailabilityStatus200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => MerchantGetAvailabilityStatus200ResponseData.fromJson(
            v as Map<String, dynamic>,
          ),
        ),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null
              ? null
              : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$MerchantGetAvailabilityStatus200ResponseToJson(
  MerchantGetAvailabilityStatus200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
