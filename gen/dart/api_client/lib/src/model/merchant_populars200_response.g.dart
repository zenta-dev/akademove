// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_populars200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantPopulars200ResponseCWProxy {
  MerchantPopulars200Response message(String? message);

  MerchantPopulars200Response data(List<Merchant> data);

  MerchantPopulars200Response pagination(PaginationResult? pagination);

  MerchantPopulars200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantPopulars200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantPopulars200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantPopulars200Response call({
    String? message,
    List<Merchant> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantPopulars200Response.copyWith(...)` or call `instanceOfMerchantPopulars200Response.copyWith.fieldName(value)` for a single field.
class _$MerchantPopulars200ResponseCWProxyImpl
    implements _$MerchantPopulars200ResponseCWProxy {
  const _$MerchantPopulars200ResponseCWProxyImpl(this._value);

  final MerchantPopulars200Response _value;

  @override
  MerchantPopulars200Response message(String? message) =>
      call(message: message);

  @override
  MerchantPopulars200Response data(List<Merchant> data) => call(data: data);

  @override
  MerchantPopulars200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  MerchantPopulars200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantPopulars200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantPopulars200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantPopulars200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantPopulars200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Merchant>,
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

extension $MerchantPopulars200ResponseCopyWith on MerchantPopulars200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantPopulars200Response.copyWith(...)` or `instanceOfMerchantPopulars200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantPopulars200ResponseCWProxy get copyWith =>
      _$MerchantPopulars200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantPopulars200Response _$MerchantPopulars200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantPopulars200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = MerchantPopulars200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Merchant.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$MerchantPopulars200ResponseToJson(
  MerchantPopulars200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
