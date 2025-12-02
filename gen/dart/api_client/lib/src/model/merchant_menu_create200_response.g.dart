// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_menu_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantMenuCreate200ResponseCWProxy {
  MerchantMenuCreate200Response message(String message);

  MerchantMenuCreate200Response data(MerchantMenu data);

  MerchantMenuCreate200Response pagination(PaginationResult? pagination);

  MerchantMenuCreate200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantMenuCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantMenuCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantMenuCreate200Response call({
    String message,
    MerchantMenu data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantMenuCreate200Response.copyWith(...)` or call `instanceOfMerchantMenuCreate200Response.copyWith.fieldName(value)` for a single field.
class _$MerchantMenuCreate200ResponseCWProxyImpl implements _$MerchantMenuCreate200ResponseCWProxy {
  const _$MerchantMenuCreate200ResponseCWProxyImpl(this._value);

  final MerchantMenuCreate200Response _value;

  @override
  MerchantMenuCreate200Response message(String message) => call(message: message);

  @override
  MerchantMenuCreate200Response data(MerchantMenu data) => call(data: data);

  @override
  MerchantMenuCreate200Response pagination(PaginationResult? pagination) => call(pagination: pagination);

  @override
  MerchantMenuCreate200Response totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantMenuCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantMenuCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantMenuCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantMenuCreate200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as MerchantMenu,
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

extension $MerchantMenuCreate200ResponseCopyWith on MerchantMenuCreate200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantMenuCreate200Response.copyWith(...)` or `instanceOfMerchantMenuCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantMenuCreate200ResponseCWProxy get copyWith => _$MerchantMenuCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantMenuCreate200Response _$MerchantMenuCreate200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MerchantMenuCreate200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = MerchantMenuCreate200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert('data', (v) => MerchantMenu.fromJson(v as Map<String, dynamic>)),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null ? null : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$MerchantMenuCreate200ResponseToJson(MerchantMenuCreate200Response instance) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
