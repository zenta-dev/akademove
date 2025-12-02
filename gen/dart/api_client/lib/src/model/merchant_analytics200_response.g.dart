// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_analytics200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantAnalytics200ResponseCWProxy {
  MerchantAnalytics200Response message(String message);

  MerchantAnalytics200Response data(MerchantAnalytics200ResponseData data);

  MerchantAnalytics200Response pagination(PaginationResult? pagination);

  MerchantAnalytics200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantAnalytics200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantAnalytics200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantAnalytics200Response call({
    String message,
    MerchantAnalytics200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantAnalytics200Response.copyWith(...)` or call `instanceOfMerchantAnalytics200Response.copyWith.fieldName(value)` for a single field.
class _$MerchantAnalytics200ResponseCWProxyImpl implements _$MerchantAnalytics200ResponseCWProxy {
  const _$MerchantAnalytics200ResponseCWProxyImpl(this._value);

  final MerchantAnalytics200Response _value;

  @override
  MerchantAnalytics200Response message(String message) => call(message: message);

  @override
  MerchantAnalytics200Response data(MerchantAnalytics200ResponseData data) => call(data: data);

  @override
  MerchantAnalytics200Response pagination(PaginationResult? pagination) => call(pagination: pagination);

  @override
  MerchantAnalytics200Response totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantAnalytics200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantAnalytics200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantAnalytics200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantAnalytics200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as MerchantAnalytics200ResponseData,
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

extension $MerchantAnalytics200ResponseCopyWith on MerchantAnalytics200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantAnalytics200Response.copyWith(...)` or `instanceOfMerchantAnalytics200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantAnalytics200ResponseCWProxy get copyWith => _$MerchantAnalytics200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantAnalytics200Response _$MerchantAnalytics200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MerchantAnalytics200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = MerchantAnalytics200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert('data', (v) => MerchantAnalytics200ResponseData.fromJson(v as Map<String, dynamic>)),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null ? null : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$MerchantAnalytics200ResponseToJson(MerchantAnalytics200Response instance) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
