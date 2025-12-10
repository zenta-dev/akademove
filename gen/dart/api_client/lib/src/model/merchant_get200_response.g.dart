// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_get200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantGet200ResponseCWProxy {
  MerchantGet200Response message(String message);

  MerchantGet200Response data(Merchant data);

  MerchantGet200Response pagination(PaginationResult? pagination);

  MerchantGet200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantGet200Response call({
    String message,
    Merchant data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantGet200Response.copyWith(...)` or call `instanceOfMerchantGet200Response.copyWith.fieldName(value)` for a single field.
class _$MerchantGet200ResponseCWProxyImpl
    implements _$MerchantGet200ResponseCWProxy {
  const _$MerchantGet200ResponseCWProxyImpl(this._value);

  final MerchantGet200Response _value;

  @override
  MerchantGet200Response message(String message) => call(message: message);

  @override
  MerchantGet200Response data(Merchant data) => call(data: data);

  @override
  MerchantGet200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  MerchantGet200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantGet200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantGet200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Merchant,
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

extension $MerchantGet200ResponseCopyWith on MerchantGet200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantGet200Response.copyWith(...)` or `instanceOfMerchantGet200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantGet200ResponseCWProxy get copyWith =>
      _$MerchantGet200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantGet200Response _$MerchantGet200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantGet200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = MerchantGet200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Merchant.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$MerchantGet200ResponseToJson(
  MerchantGet200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
