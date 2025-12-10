// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_order_accept200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantOrderAccept200ResponseCWProxy {
  MerchantOrderAccept200Response message(String? message);

  MerchantOrderAccept200Response data(Order data);

  MerchantOrderAccept200Response pagination(PaginationResult? pagination);

  MerchantOrderAccept200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantOrderAccept200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantOrderAccept200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantOrderAccept200Response call({
    String? message,
    Order data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantOrderAccept200Response.copyWith(...)` or call `instanceOfMerchantOrderAccept200Response.copyWith.fieldName(value)` for a single field.
class _$MerchantOrderAccept200ResponseCWProxyImpl
    implements _$MerchantOrderAccept200ResponseCWProxy {
  const _$MerchantOrderAccept200ResponseCWProxyImpl(this._value);

  final MerchantOrderAccept200Response _value;

  @override
  MerchantOrderAccept200Response message(String? message) =>
      call(message: message);

  @override
  MerchantOrderAccept200Response data(Order data) => call(data: data);

  @override
  MerchantOrderAccept200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  MerchantOrderAccept200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantOrderAccept200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantOrderAccept200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantOrderAccept200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantOrderAccept200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Order,
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

extension $MerchantOrderAccept200ResponseCopyWith
    on MerchantOrderAccept200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantOrderAccept200Response.copyWith(...)` or `instanceOfMerchantOrderAccept200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantOrderAccept200ResponseCWProxy get copyWith =>
      _$MerchantOrderAccept200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantOrderAccept200Response _$MerchantOrderAccept200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantOrderAccept200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = MerchantOrderAccept200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => Order.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$MerchantOrderAccept200ResponseToJson(
  MerchantOrderAccept200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
