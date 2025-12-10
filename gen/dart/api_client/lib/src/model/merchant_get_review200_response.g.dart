// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_get_review200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantGetReview200ResponseCWProxy {
  MerchantGetReview200Response message(String message);

  MerchantGetReview200Response data(MerchantGetReview200ResponseData data);

  MerchantGetReview200Response pagination(PaginationResult? pagination);

  MerchantGetReview200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantGetReview200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantGetReview200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantGetReview200Response call({
    String message,
    MerchantGetReview200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantGetReview200Response.copyWith(...)` or call `instanceOfMerchantGetReview200Response.copyWith.fieldName(value)` for a single field.
class _$MerchantGetReview200ResponseCWProxyImpl
    implements _$MerchantGetReview200ResponseCWProxy {
  const _$MerchantGetReview200ResponseCWProxyImpl(this._value);

  final MerchantGetReview200Response _value;

  @override
  MerchantGetReview200Response message(String message) =>
      call(message: message);

  @override
  MerchantGetReview200Response data(MerchantGetReview200ResponseData data) =>
      call(data: data);

  @override
  MerchantGetReview200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  MerchantGetReview200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantGetReview200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantGetReview200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantGetReview200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantGetReview200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as MerchantGetReview200ResponseData,
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

extension $MerchantGetReview200ResponseCopyWith
    on MerchantGetReview200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantGetReview200Response.copyWith(...)` or `instanceOfMerchantGetReview200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantGetReview200ResponseCWProxy get copyWith =>
      _$MerchantGetReview200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantGetReview200Response _$MerchantGetReview200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantGetReview200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = MerchantGetReview200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) =>
          MerchantGetReview200ResponseData.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$MerchantGetReview200ResponseToJson(
  MerchantGetReview200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
