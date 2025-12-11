// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_operating_hours_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantOperatingHoursList200ResponseCWProxy {
  MerchantOperatingHoursList200Response message(String message);

  MerchantOperatingHoursList200Response data(List<MerchantOperatingHours> data);

  MerchantOperatingHoursList200Response pagination(
    PaginationResult? pagination,
  );

  MerchantOperatingHoursList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantOperatingHoursList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantOperatingHoursList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantOperatingHoursList200Response call({
    String message,
    List<MerchantOperatingHours> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantOperatingHoursList200Response.copyWith(...)` or call `instanceOfMerchantOperatingHoursList200Response.copyWith.fieldName(value)` for a single field.
class _$MerchantOperatingHoursList200ResponseCWProxyImpl
    implements _$MerchantOperatingHoursList200ResponseCWProxy {
  const _$MerchantOperatingHoursList200ResponseCWProxyImpl(this._value);

  final MerchantOperatingHoursList200Response _value;

  @override
  MerchantOperatingHoursList200Response message(String message) =>
      call(message: message);

  @override
  MerchantOperatingHoursList200Response data(
    List<MerchantOperatingHours> data,
  ) => call(data: data);

  @override
  MerchantOperatingHoursList200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  MerchantOperatingHoursList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantOperatingHoursList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantOperatingHoursList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantOperatingHoursList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantOperatingHoursList200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<MerchantOperatingHours>,
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

extension $MerchantOperatingHoursList200ResponseCopyWith
    on MerchantOperatingHoursList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantOperatingHoursList200Response.copyWith(...)` or `instanceOfMerchantOperatingHoursList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantOperatingHoursList200ResponseCWProxy get copyWith =>
      _$MerchantOperatingHoursList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantOperatingHoursList200Response
_$MerchantOperatingHoursList200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MerchantOperatingHoursList200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = MerchantOperatingHoursList200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>)
              .map(
                (e) =>
                    MerchantOperatingHours.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
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

Map<String, dynamic> _$MerchantOperatingHoursList200ResponseToJson(
  MerchantOperatingHoursList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
