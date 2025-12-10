// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_get_mine200_response_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantGetMine200ResponseBodyCWProxy {
  MerchantGetMine200ResponseBody message(String? message);

  MerchantGetMine200ResponseBody data(Merchant data);

  MerchantGetMine200ResponseBody pagination(PaginationResult? pagination);

  MerchantGetMine200ResponseBody totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantGetMine200ResponseBody(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantGetMine200ResponseBody(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantGetMine200ResponseBody call({
    String? message,
    Merchant data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantGetMine200ResponseBody.copyWith(...)` or call `instanceOfMerchantGetMine200ResponseBody.copyWith.fieldName(value)` for a single field.
class _$MerchantGetMine200ResponseBodyCWProxyImpl
    implements _$MerchantGetMine200ResponseBodyCWProxy {
  const _$MerchantGetMine200ResponseBodyCWProxyImpl(this._value);

  final MerchantGetMine200ResponseBody _value;

  @override
  MerchantGetMine200ResponseBody message(String? message) =>
      call(message: message);

  @override
  MerchantGetMine200ResponseBody data(Merchant data) => call(data: data);

  @override
  MerchantGetMine200ResponseBody pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  MerchantGetMine200ResponseBody totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantGetMine200ResponseBody(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantGetMine200ResponseBody(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantGetMine200ResponseBody call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantGetMine200ResponseBody(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
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

extension $MerchantGetMine200ResponseBodyCopyWith
    on MerchantGetMine200ResponseBody {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantGetMine200ResponseBody.copyWith(...)` or `instanceOfMerchantGetMine200ResponseBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantGetMine200ResponseBodyCWProxy get copyWith =>
      _$MerchantGetMine200ResponseBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantGetMine200ResponseBody _$MerchantGetMine200ResponseBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantGetMine200ResponseBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = MerchantGetMine200ResponseBody(
    message: $checkedConvert('message', (v) => v as String?),
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

Map<String, dynamic> _$MerchantGetMine200ResponseBodyToJson(
  MerchantGetMine200ResponseBody instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
