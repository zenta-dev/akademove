// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_best_sellers200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantBestSellers200ResponseCWProxy {
  MerchantBestSellers200Response message(String? message);

  MerchantBestSellers200Response data(
    List<MerchantBestSellers200ResponseDataInner> data,
  );

  MerchantBestSellers200Response pagination(PaginationResult? pagination);

  MerchantBestSellers200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantBestSellers200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantBestSellers200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantBestSellers200Response call({
    String? message,
    List<MerchantBestSellers200ResponseDataInner> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantBestSellers200Response.copyWith(...)` or call `instanceOfMerchantBestSellers200Response.copyWith.fieldName(value)` for a single field.
class _$MerchantBestSellers200ResponseCWProxyImpl
    implements _$MerchantBestSellers200ResponseCWProxy {
  const _$MerchantBestSellers200ResponseCWProxyImpl(this._value);

  final MerchantBestSellers200Response _value;

  @override
  MerchantBestSellers200Response message(String? message) =>
      call(message: message);

  @override
  MerchantBestSellers200Response data(
    List<MerchantBestSellers200ResponseDataInner> data,
  ) => call(data: data);

  @override
  MerchantBestSellers200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  MerchantBestSellers200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantBestSellers200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantBestSellers200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantBestSellers200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantBestSellers200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<MerchantBestSellers200ResponseDataInner>,
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

extension $MerchantBestSellers200ResponseCopyWith
    on MerchantBestSellers200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantBestSellers200Response.copyWith(...)` or `instanceOfMerchantBestSellers200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantBestSellers200ResponseCWProxy get copyWith =>
      _$MerchantBestSellers200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantBestSellers200Response _$MerchantBestSellers200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantBestSellers200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = MerchantBestSellers200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map(
            (e) => MerchantBestSellers200ResponseDataInner.fromJson(
              e as Map<String, dynamic>,
            ),
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

Map<String, dynamic> _$MerchantBestSellers200ResponseToJson(
  MerchantBestSellers200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
